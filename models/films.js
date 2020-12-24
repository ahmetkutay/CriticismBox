const mongoose = require('mongoose');

const dotenv = require('dotenv');



dotenv.config();



const FilmScheme = new mongoose.Schema({
    catId:{
        type:Object
    },
    FilmImgUrl: {
        type: String,
    },
    FilmName: {
        type: String,
    },
    FilmDesc:{
        type:String
    }
});

module.exports = mongoose.model('Film', FilmScheme);