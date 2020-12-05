const mongoose = require('mongoose');

const dotenv = require('dotenv');



dotenv.config();



const CategoryScheme = new mongoose.Schema({
    catId:{
        type: String,
    },
    catName: {
        type: String,
    },
});

module.exports = mongoose.model('Category', CategoryScheme);