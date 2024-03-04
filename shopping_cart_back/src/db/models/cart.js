const mongoose = require("mongoose");
const { Schema } = mongoose;

const cartSchema = new Schema({
    userId: { type: Schema.Types.ObjectId, ref: 'User' },
    items: [{ productId: Schema.Types.ObjectId, quantity: Number }]
});

const Cart = mongoose.model('Cart', cartSchema, 'cart');

module.exports = Cart;