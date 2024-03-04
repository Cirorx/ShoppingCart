const Product = require("./models/product");
const Cart = require("./models/cart");
const mongoose = require('mongoose');

const getAllProducts = async () => {
    try {
        const products = await Product.find();
        return products;
    } catch (error) {
        console.error("There was an error fetching the products:", error);
        throw error;
    }
};


const getStockReport = async () => {
    try {
        const report = await Product.aggregate([
            {
                $group: {
                    _id: "$category",
                    totalStock: { $sum: "$stock" },
                },
            },
        ]);
        return report;
    } catch (error) {
        console.error("There was an error getting the report:", error);
        throw error;
    }
};

const modifyCart = async (userId, productId, quantity) => {
    try {

        const userObjectId = new mongoose.Types.ObjectId(userId);

        const product = await Product.findById(productId);
        if (!product) {
            throw new Error("Product not found");
        }

        // check stock available
        if (quantity > 0 && quantity > product.stock) {
            throw new Error("Quantity exceeds available stock");
        }

        let cart = await Cart.findOne({ userId: userObjectId });
        if (!cart) {
            cart = new Cart({ userId, items: [] });
        }

        // update quantity
        const productIndex = cart.items.findIndex(item => item.productId.equals(productId));
        if (productIndex !== -1) {
            cart.items[productIndex].quantity = cart.items[productIndex].quantity + quantity;
        } else if (quantity > 0) {
            cart.items.push({ productId, quantity });
        }

        // update stock
        product.stock = product.stock - quantity;

        await product.save();
        await cart.save();

        return "Cart was modified successfully!";
    } catch (error) {
        console.error("Error modifying cart:", error);
        throw new Error("An error occurred while modifying the cart");
    }
};

module.exports = {
    getAllProducts,
    getStockReport,
    modifyCart,
};
