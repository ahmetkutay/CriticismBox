    const mongoose = require('mongoose');
    const jwt = require('jsonwebtoken');
    const bcrypt = require('bcrypt');
    const confiq = require('../config/config').get(process.env.NODE_ENV);
    const salt = 10;
    const dotenv = require('dotenv');



    dotenv.config();



    const userScheme = new mongoose.Schema({
        name: {
            type: String,
            required: true,
            min: 8
        },
        email: {
            type: String,
            required: true,
            max: 255,
            min: 11
        },
        password: {
            type: String,
            required: true,
            max: 1024,
            min: 8
        },
        favorite:[{
            whatHaveYou: String,
        }],
        token: {
            type: String
        }
    });

    userScheme.pre('save', function (next) {
        var user = this;

        if (user.isModified('password')) {
            bcrypt.genSalt(salt, function (err, salt) {
                if (err) return next(err);

                bcrypt.hash(user.password, salt, function (err, hash) {
                    if (err) return next(err);
                    user.password = hash;
                    next();
                })

            })
        }
        else {
            next();
        }
    });

    userScheme.methods.comparepassword = function (password, cb) {
        bcrypt.compare(password, this.password, function (err, isMatch) {
            if (err) return cb(next);
            cb(null, isMatch);
        });
    };

    userScheme.methods.generateToken = function (cb) {
        var user = this;
        var token = jwt.sign(user._id.toHexString(), process.env.secret);

        user.token = token;
        user.save(function (err, user) {
            if (err) return cb(err);
            cb(null, user);
        })
    };

    userScheme.statics.findByToken = function (token, cb) {
        var user = this;

        jwt.verify(token, confiq.SECRET, function (err, decode) {
            user.findOne({ "_id": decode, "token": token }, function (err, user) {
                if (err) return cb(err);
                cb(null, user);
            })
        })
    };

    userScheme.methods.deleteToken = function (token, cb) {
        var user = this;

        user.update({ $unset: { token: 1 } }, function (err, user) {
            if (err) return cb(err);
            cb(null, user);
        })
    };

    module.exports = mongoose.model('User', userScheme);