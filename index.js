const express = require('express');
const mongoose = require('mongoose');
const bodyparser = require('body-parser');
const cookieParser = require('cookie-parser');
const dotenv = require('dotenv');
const User = require('./models/user');
const { auth } = require('./middlewares/auth');
const confiq = require('./config/config');
const Category = require('./models/category');
var MongoClient = require('mongodb').MongoClient;
var mongo = require('mongodb');
var assert = require('assert');


const app = express();
// app use
app.use(bodyparser.urlencoded({ extended: false }));
app.use(bodyparser.json());
app.use(cookieParser());

// database connection
dotenv.config();


mongoose.connect(
    process.env.DB_CONNECT,
    {
        useUnifiedTopology: true,
        useNewUrlParser: true
    },
    () => console.log('connected db')
);

app.get('/', function (req, res) {
    res.status(200).send(`Orhun Çok Boş Yaptın.`);
});

// listening port
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`app is live at ${PORT}`);
});

// adding new user (sign-up route)
app.post('/api/register', function (req, res) {
    // taking a user
    const newuser = new User(req.body);

    User.findOne({ email: newuser.email }, function (err, user) {
        if (user) return res.status(400).json({ auth: false, message: "email exits" });

        newuser.save((err, doc) => {
            if (err) {
                console.log(err);
                return res.status(400).json({ success: false });
            }
            res.status(200).json({
                succes: true,
                user: doc
            });
        });
    });
});

// login user
app.post('/api/login', function (req, res) {
    let token = req.cookies.auth;
    User.findByToken(token, (err, user) => {
        if (err) return res(err);
        if (user) return res.status(400).json({
            error: true,
            message: "You are already logged in"
        });

        else {
            User.findOne({ 'email': req.body.email }, function (err, user) {
                if (!user) return res.json({ isAuth: false, message: ' Auth failed ,email not found' });

                user.comparepassword(req.body.password, (err, isMatch) => {
                    if (!isMatch) return res.json({ isAuth: false, message: "password doesn't match" });

                    user.generateToken((err, user) => {
                        if (err) return res.status(400).send(err);
                        res.cookie('auth', user.token).json({
                            isAuth: true,
                            id: user._id,
                            email: user.email

                        });
                    });
                });
            });
        }
    });
});

// get logged in user
app.get('/api/profile', auth, function (req, res) {
    res.json({
        isAuth: true,
        id: req.user._id,
        email: req.user.email,
        name: req.user.name

    })
});

//logout user
app.get('/api/logout', auth, function (req, res) {
    req.user.deleteToken(req.token, (err, user) => {
        if (err) return res.status(400).send(err);
        res.sendStatus(200);
    });

});

// Film Api

app.get('/api/category/film', function (req, res, err) {

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        if (err) throw err;
        var dbo = db.db("test");
        dbo.collection("Category").find({}).toArray(function (err, result) {
            if (err) throw err;
            res.json({
                cat: result
            });
            db.close();
        });
    });

});

// Dizi Api

app.get('/api/category/dizi', function (req, res, err) {

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        if (err) throw err;
        var dbo = db.db("test");
        dbo.collection("Diziler").find({}).toArray(function (err, result) {
            if (err) throw err;
            res.json({
                cat: result
            });
            db.close();
        });
    });

});

// Kitap Api

app.get('/api/category/kitap', function (req, res, err) {

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        if (err) throw err;
        var dbo = db.db("test");
        dbo.collection("Kitaplar").find({}).toArray(function (err, result) {
            if (err) throw err;
            res.json({
                cat: result
            });
            db.close();
        });
    });
});

// Film favori listeleme

app.get('/api/users/film_favori', function (req, res, err) {

    var query = { kullanici_Id : req.body._id }

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        var dbo = db.db("test");
        dbo.collection("FilmFavori").find(query).toArray(function (err, result) {
            if (err) throw err;
            res.json({
                fav: result
            });
            db.close();
        });
    });
});


//Film favori alma


app.post('/api/users/film_insert_favori', function (req, res, next) {

    var item = {
        kullanici_Id: req.body._id,
        favori_Id: req.body.fav_Id,
        moviename: req.body.moviename,
        imgurl: req.body.imgurl,
        overview: req.body.overview,
        date: req.body.date,
        duration: req.body.duration,
        budget: req.body.budget
    };


    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        assert.strictEqual(null, err);
        var dbo = db.db("test");
        dbo.collection("FilmFavori").insertOne(item, function (err, result) {
            assert.strictEqual(null, err);
            db.close();
        });
    });
    res.redirect('/api/users/film_favori');
});


// Kitap favori listeleme

app.get('/api/users/kitap_favori', function (req, res, err) {

    var query = { kullanici_Id: req.body._id }

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        var dbo = db.db("test");
        dbo.collection("KitapFavori").find(query).toArray(function (err, result) {
            if (err) throw err;
            res.json({
                fav: result
            });
            db.close();
        });
    });
});


//Kitap favori alma


app.post('/api/users/kitap_insert_favori', function (req, res, next) {

    var item = {
        kullanici_Id: req.body._id,
        favori_Id: req.body.fav_Id,
        moviename: req.body.moviename,
        imgurl: req.body.imgurl,
        overview: req.body.overview,
        date: req.body.date,
        duration: req.body.duration,
        budget: req.body.budget
    };


    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        assert.strictEqual(null, err);
        var dbo = db.db("test");
        dbo.collection("KitapFavori").insertOne(item, function (err, result) {
            assert.strictEqual(null, err);
            db.close();
        });
    });
    res.redirect('/api/users/kitap_favori');
});

//Dizi favori gösterme

app.get('/api/users/dizi_favori', function (req, res, err) {

    var query = { kullanici_Id: req.body._id }

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        var dbo = db.db("test");
        dbo.collection("DiziFavori").find(query).toArray(function (err, result) {
            if (err) throw err;
            res.json({
                fav: result
            });
            db.close();
        });
    });
});


//Dizi favori alma


app.post('/api/users/dizi_insert_favori', function (req, res, next) {

    var item = {
        kullanici_Id: req.body._id,
        favori_Id: req.body.fav_Id,
        moviename: req.body.moviename,
        imgurl: req.body.imgurl,
        overview: req.body.overview,
        date: req.body.date,
        duration: req.body.duration,
        budget: req.body.budget
    };


    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        assert.strictEqual(null, err);
        var dbo = db.db("test");
        dbo.collection("DiziFavori").insertOne(item, function (err, result) {
            assert.strictEqual(null, err);
            db.close();
        });
    });
    res.redirect('/api/users/dizi_favori');
});

// favori silme

app.post('/api/users/favori_delete', function (req, res, next) {

    var query = { kullanici_Id: req.query.kullanici_id }
    var query_2 = { urun_id: req.query.urun_id }
    var mongoId = req.body._id

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        assert.strictEqual(null, err);
        var dbo = db.db("test");
        dbo.collection("FilmFavori").find(query, function (err, result) {
                dbo.collection("FilmFavori").deleteOne({ "_id": mongo.ObjectId(mongoId) }, function (err, result) {
                    db.close();
                });
        });

        dbo.collection("DiziFavori").find(query, function (err, result) {
                dbo.collection("DiziFavori").deleteOne({ "_id": mongo.ObjectId(mongoId) }, function (err, result) {
                    db.close();
                });
        });

        dbo.collection("KitapFavori").find(query, function (err, result) {
                dbo.collection("KitapFavori").deleteOne({ "_id": mongo.ObjectId(mongoId) }, function (err, result) {
                    db.close();
                });
        });
    });
    res.send('Seçilen Veri Silindi.');
});




// Yorum listeleme

app.get('/api/users/yorum', function (req, res, err) {

    var query = { kullanici_Id: req.query.kullanici_id }

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        var dbo = db.db("test");
        dbo.collection("KullaniciYorum").find(query).toArray(function (err, result) {
            if (err) throw err;
            res.json({
                fav: result
            });
            db.close();
        });
    });
});

//Ürüm Yorum Listemele

app.get('/api/users/urun_yorum', function (req, res, err) {

    var query = { urun_Id: req.query.urun_Id }

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        var dbo = db.db("test");
        dbo.collection("KullaniciYorum").find(query).toArray(function (err, result) {
            if (err) throw err;
            res.json({
                fav: result
            });
            db.close();
        });
    });
});


//yorum insert apisi


app.post('/api/users/yorum_insert', function (req, res, next) {

    var item = {
        kullanici_Id: req.body._id,
        urun_Id: req.body.fav_Id,
        kullanici_name: req.body.kullaniciAdi,
        kullanici_Yorum: req.body.yorum

    };

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        assert.strictEqual(null, err);
        var dbo = db.db("test");
        dbo.collection("KullaniciYorum").insertOne(item, function (err, result) {
            assert.strictEqual(null, err);
            db.close();
        });
    });
    res.redirect('/api/users/yorum');
});


// yorum silme apisi

app.post('/api/users/yorum_delete', function (req, res, next) {

    var query = { yorum_Id: req.query.kullanici_id }
    var mongoId = req.body._id;

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        assert.strictEqual(null, err);
        var dbo = db.db("test");
        dbo.collection("KullaniciYorum").find(query, function (err, result) {
            dbo.collection("KullaniciYorum").deleteOne({ "_id": mongo.ObjectId(mongoId) }, function (err, result) {
                assert.strictEqual(null, err);
                db.close();
            });
        });
        res.redirect('/api/users/yorum');
    })
});


// yorum update apisi


app.post('/api/users/yorum_update', function (req, res, next) {

    var item = {
        kullanici_Id: req.body.kullanici_id,
        urun_Id: req.body.fav_Id,
        kullanici_name: req.body.kullaniciAdi,
        kullanici_Yorum: req.body.yorum
    };

    var mongoId = req.body._id;

    MongoClient.connect(process.env.DB_CONNECT, { useUnifiedTopology: true }, function (err, db) {
        assert.strictEqual(null, err);
        var dbo = db.db("test");
        dbo.collection("KullaniciYorum").updateOne({ "_id": mongo.ObjectId(mongoId) }, { $set: item }, function (err, result) {
            assert.strictEqual(null, err);
            db.close();
        });
    });
    res.redirect('/api/users/yorum');
});
