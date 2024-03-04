const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    name: { type: String, required: true },
    cart: { type: Schema.Types.ObjectId, ref: 'Cart' }
});

const User = mongoose.model('User', userSchema, 'users');

module.exports = User;
