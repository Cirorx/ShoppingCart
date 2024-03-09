const mongoose = require('mongoose');
const { Schema } = mongoose;

const userSchema = new mongoose.Schema({
    email: { type: String, required: true, unique: true, index: true },
    cart: { type: Schema.Types.ObjectId, ref: 'Cart' }
});

const User = mongoose.model('User', userSchema, 'users');

module.exports = User;
