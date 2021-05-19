const express = require("express");
const mongoose = require("mongoose");
const bodyparser = require("body-parser");
const cookieParser = require("cookie-parser");
const dotenv = require("dotenv");
const User = require("./models/user");
const { auth } = require("./middlewares/auth");
var MongoClient = require("mongodb").MongoClient;
var mongo = require("mongodb");
var assert = require("assert");

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
    useNewUrlParser: true,
  },
  () => console.log("connected db")
);

app.get("/", function (req, res) {
  res.status(200).send(`Bitirme Ödevimize Hoşgeldiniz`);
});

// listening port
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`app is live at ${PORT}`);
});

// register apisi
app.post("/api/register", function (req, res) {
  // taking a user
  const newuser = new User(req.body);

  User.findOne({ email: newuser.email }, function (err, user) {
    if (user)
      return res.status(400).json({ auth: false, message: "email exits" });

    newuser.save((err, doc) => {
      if (err) {
        console.log(err);
        return res.status(400).json({ success: false });
      }
      res.status(200).json({
        succes: true,
        user: doc,
      });
    });
  });
});

// login user
app.post("/api/login", function (req, res) {
  let token = req.cookies.auth;
  User.findByToken(token, (err, user) => {
    if (err) return res(err);
    if (user)
      return res.status(400).json({
        error: true,
        message: "You are already logged in",
      });
    else {
      User.findOne({ email: req.body.email }, function (err, user) {
        if (!user)
          return res.json({
            isAuth: false,
            message: " Auth failed ,email not found",
          });

        user.comparepassword(req.body.password, (err, isMatch) => {
          if (!isMatch)
            return res.json({
              isAuth: false,
              message: "password doesn't match",
            });

          user.generateToken((err, user) => {
            if (err) return res.status(400).send(err);
            res.cookie("auth", user.token).json({
              isAuth: true,
              id: user._id,
              email: user.email,
              name: user.name,
            });
          });
        });
      });
    }
  });
});

// get logged in user
app.get("/api/profile", auth, function (req, res) {
  res.json({
    isAuth: true,
    id: req.user._id,
    email: req.user.email,
    name: req.user.name,
  });
});

//logout user
app.get("/api/logout", auth, function (req, res) {
  req.user.deleteToken(req.token, (err, user) => {
    if (err) return res.status(400).send(err);
    res.sendStatus(200);
  });
});

// Film Api

app.get("/api/category/film", function (req, res, err) {
  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      if (err) throw err;
      var dbo = db.db("test");
      dbo
        .collection("Category")
        .find({})
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            cat: result,
          });
          db.close();
        });
    }
  );
});

// Dizi Api

app.get("/api/category/dizi", function (req, res, err) {
  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      if (err) throw err;
      var dbo = db.db("test");
      dbo
        .collection("Diziler")
        .find({})
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            cat: result,
          });
          db.close();
        });
    }
  );
});

// Kitap Api

app.get("/api/category/kitap", function (req, res, err) {
  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      if (err) throw err;
      var dbo = db.db("test");
      dbo
        .collection("Kitaplar")
        .find({})
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            cat: result,
          });
          db.close();
        });
    }
  );
});

// Film favori listeleme

app.get("/api/users/film_favori", function (req, res, err) {
  var query = { kullanici_Id: req.query._id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("FilmFavori")
        .find(query)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            fav: result,
          });
          db.close();
        });
    }
  );
});

//Film favori alma

app.post("/api/users/film_insert_favori", function (req, res, next) {
  var item = {
    kullanici_Id: req.body._id,
    favori_Id: req.body.fav_Id,
    moviename: req.body.moviename,
    imgurl: req.body.imgurl,
    overview: req.body.overview,
    date: req.body.date,
    duration: req.body.duration,
    budget: req.body.budget,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("FilmFavori").insertOne(item, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.send("Favori Eklendi");
});

// Film favori silme

app.post("/api/users/film_delete_favori", function (req, res, next) {
  var query = { favori_Id: req.body.fav_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("FilmFavori").deleteOne(query, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.redirect("/api/users/film_favori");
});

// Kitap favori listeleme

app.get("/api/users/kitap_favori", function (req, res, err) {
  var query = { kullanici_Id: req.query._id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("KitapFavori")
        .find(query)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            fav: result,
          });
          db.close();
        });
    }
  );
});

//Kitap favori alma

app.post("/api/users/kitap_insert_favori", function (req, res, next) {
  var item = {
    kullanici_Id: req.body._id,
    favori_Id: req.body.fav_Id,
    moviename: req.body.moviename,
    imgurl: req.body.imgurl,
    overview: req.body.overview,
    date: req.body.date,
    duration: req.body.duration,
    budget: req.body.budget,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("KitapFavori").insertOne(item, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.redirect("/api/users/kitap_favori");
});

// favori silme bakılıcak asserion null error bak

app.post("/api/users/favori_delete", function (req, res, next) {
  var query = { kullanici_Id: req.query.kullanici_id };
  var query_2 = { urun_id: req.query.urun_id };
  var mongoId = req.body._id;

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("FilmFavori").find(query, function (err, result) {
        dbo
          .collection("FilmFavori")
          .deleteOne({ _id: mongo.ObjectId(mongoId) }, function (err, result) {
            db.close();
          });
      });

      dbo.collection("DiziFavori").find(query, function (err, result) {
        dbo
          .collection("DiziFavori")
          .deleteOne({ _id: mongo.ObjectId(mongoId) }, function (err, result) {
            db.close();
          });
      });

      dbo.collection("KitapFavori").find(query, function (err, result) {
        dbo
          .collection("KitapFavori")
          .deleteOne({ _id: mongo.ObjectId(mongoId) }, function (err, result) {
            db.close();
          });
      });
    }
  );
  res.send("Seçilen Veri Silindi.");
});

// Dizi favori listeleme

app.get("/api/users/dizi_favori", function (req, res, err) {
  var query = { kullanici_Id: req.query._id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("DiziFavori")
        .find(query)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            fav: result,
          });
          db.close();
        });
    }
  );
});

//Dizi favori alma

app.post("/api/users/dizi_insert_favori", function (req, res, next) {
  var item = {
    kullanici_Id: req.body._id,
    favori_Id: req.body.fav_Id,
    moviename: req.body.moviename,
    imgurl: req.body.imgurl,
    overview: req.body.overview,
    date: req.body.date,
    duration: req.body.duration,
    budget: req.body.budget,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("DiziFavori").insertOne(item, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.redirect("/api/users/dizi_favori");
});

// Dizi favori silme

app.post("/api/users/dizi_delete_favori", function (req, res, next) {
  var query = { favori_Id: req.body.fav_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("DiziFavori").deleteOne(query, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.redirect("/api/users/dizi_favori");
});

// Yorum listeleme

app.get("/api/users/yorum", function (req, res, err) {
  var query = { kullanici_Id: req.query.kullanici_id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("KullaniciYorum")
        .find(query)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            fav: result,
          });
          db.close();
        });
    }
  );
});

//Ürüm Yorum Listemele

app.get("/api/users/urun_yorum", function (req, res, err) {
  var query = { urun_Id: req.query.urun_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("KullaniciYorum")
        .find(query)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            fav: result,
          });
          db.close();
        });
    }
  );
});

//yorum insert apisi

app.post("/api/users/yorum_insert", function (req, res, next) {
  var item = {
    kullanici_Id: req.body._id,
    urun_Id: req.body.fav_Id,
    kullanici_name: req.body.kullaniciAdi,
    kullanici_Yorum: req.body.yorum,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("KullaniciYorum").insertOne(item, function (err, result) {
        assert.strictEqual(null, err);
        db.close();
      });
    }
  );
  res.redirect("/api/users/yorum");
});

// yorum silme apisi

app.post("/api/users/yorum_delete", function (req, res, next) {
  var query = { yorum_Id: req.query.kullanici_id };
  var mongoId = req.body._id;

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo.collection("KullaniciYorum").find(query, function (err, result) {
        dbo
          .collection("KullaniciYorum")
          .deleteOne({ _id: mongo.ObjectId(mongoId) }, function (err, result) {
            assert.strictEqual(null, err);
            db.close();
          });
      });
      res.redirect("/api/users/yorum");
    }
  );
});

// yorum update apisi

app.post("/api/users/yorum_update", function (req, res, next) {
  var item = {
    kullanici_Id: req.body.kullanici_id,
    urun_Id: req.body.fav_Id,
    kullanici_name: req.body.kullaniciAdi,
    kullanici_Yorum: req.body.yorum,
  };

  var mongoId = req.body._id;

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      dbo
        .collection("KullaniciYorum")
        .updateOne(
          { _id: mongo.ObjectId(mongoId) },
          { $set: item },
          function (err, result) {
            assert.strictEqual(null, err);
            db.close();
          }
        );
    }
  );
  res.redirect("/api/users/yorum");
});

app.get("/api/tweet", function (req, res, err) {
  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      if (err) throw err;
      var dbo = db.db("test");
      dbo
        .collection("tweet")
        .find({})
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            tweets: result,
          });
          db.close();
        });
    }
  );
});

app.post("/api/users/tweet_insert", function (req, res, next) {
  var query = { TYPE: req.query.type };
  var tweetId = { tweetId_id: req.query.yorum_Id };
  var mongoId = req.body._id;

  var item = {
    kullanici_Id: req.body._id,
    kullanici_name: req.body.kullaniciAdi,
    kullanici_tweet: req.body.yorum,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      if (query.TYPE === "INSERT") {
        dbo.collection("tweet").insertOne(item, function (err, result) {
          assert.strictEqual(null, err);
          db.close();
        });
        res.send("Veri Eklendi.");
      }

      if (query.TYPE === "DELETE") {
        dbo.collection("tweet").find(tweetId, function (err, result) {
          dbo
            .collection("tweet")
            .deleteOne(
              { _id: mongo.ObjectId(mongoId) },
              function (err, result) {
                db.close();
              }
            );
        });
        res.send("Seçilen Veri Silindi.");
      }

      if (query.TYPE === "UPDATE") {
        dbo.collection("tweet").find(tweetId, function (err, result) {
          dbo
            .collection("tweet")
            .updateOne(
              { _id: mongo.ObjectId(mongoId) },
              { $set: item },
              function (err, result) {
                assert.strictEqual(null, err);
                db.close();
              }
            );
        });
        res.send("Seçilen Veri Güncellendi.");
      }
    }
  );
});

app.get("/api/users/tweet", function (req, res, err) {
  var tweet_Id = { urun_Id: req.query.yorum_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("tweet")
        .find({})
        .toArray(function (err, result) {
          if (err) throw err;
          if (tweet_Id === null) {
            res.json({
              tweet: result,
            });
          }
          if (tweet_Id) {
            dbo
              .collection("tweet")
              .find(tweet_Id)
              .toArray(function (err, result) {
                res.json({
                  tweet: result,
                });
              });
          }
          db.close();
        });
    }
  );
});

app.post("/api/users/insert_follow", function (req, res, next) {
  var query = { TYPE: req.query.type };
  var status;
  var followedItem = {
    kullanici_Id: req.body._id,
    followed_users: req.body.followed_users_Id,
    kullanici_name: req.body.kullaniciAdi,
  };
  var followersItem = {
    kullanici_Id: req.body._id,
    followers_users: req.body.followers_users_Id,
    kullanici_name: req.body.kullaniciAdi,
  };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      if (query.TYPE === "FOLLOW") {
        dbo
          .collection("followed")
          .insertOne(followedItem, function (err, result) {
            assert.strictEqual(null, err);
            status = "Takip ediliyor";
            db.close();
          });
        res.send("Veri Eklendi.");
      } else if (query.TYPE === "FOLLOWERS") {
        dbo
          .collection("followers")
          .insertOne(followersItem, function (err, result) {
            assert.strictEqual(null, err);
            status = "Takip ediyor";
            db.close();
          });
        res.send("Veri Eklendi.");
      }
    }
  );
});

app.post("/api/users/delete_follow", function (req, res, next) {
  var query = { TYPE: req.query.type };
  var mongoId = req.body._id;

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      assert.strictEqual(null, err);
      var dbo = db.db("test");
      if (query.TYPE === "DELETE_FOLLOW") {
        dbo
          .collection("followed")
          .deleteOne({ _id: mongo.ObjectId(mongoId) }, function (err, result) {
            db.close();
          });
        res.send("Veri Eklendi.");
      } else if (query.TYPE === "DETELE_FOLLOWERS") {
        dbo
          .collection("followers")
          .deleteOne({ _id: mongo.ObjectId(mongoId) }, function (err, result) {
            db.close();
          });
        res.send("Veri Eklendi.");
      }
    }
  );
});

app.get("/api/users/followers", function (req, res, err) {
  var kullanıcı_Id = { kullanıcı_Id: req.query.kullanici_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("followers")
        .find(kullanıcı_Id)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            tweet: result,
          });
          db.close();
        });
    }
  );
});

app.get("/api/users/followed", function (req, res, err) {
  var kullanıcı_Id = { kullanıcı_Id: req.query.kullanici_Id };

  MongoClient.connect(
    process.env.DB_CONNECT,
    { useUnifiedTopology: true },
    function (err, db) {
      var dbo = db.db("test");
      dbo
        .collection("followed")
        .find(kullanıcı_Id)
        .toArray(function (err, result) {
          if (err) throw err;
          res.json({
            tweet: result,
          });
          db.close();
        });
    }
  );
});
