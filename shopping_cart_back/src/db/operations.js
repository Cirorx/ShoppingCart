const Product = require("./models/product");
const Cart = require("./models/cart");
const User = require("./models/user")
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

const modifyCart = async (userEmail, productId, quantity) => {
    try {

        const product = await Product.findById(productId);
        if (!product) {
            throw new Error("Product not found");
        }

        // check stock available
        if (quantity > 0 && quantity > product.stock) {
            throw new Error("Quantity exceeds available stock");
        }

        let cart = await Cart.findOne({ userEmail: userEmail });

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

const getProductsByCategory = async (category) => {
    try {
        const products = await Product.find({ category });
        return products;
    } catch (error) {
        console.error("There was an error fetching the products by category:", error);
        throw error;
    }
};

const createUser = async (email) => {
    try {

        const cart = new Cart({ userEmail: email, items: [] });
        await cart.save();

        const user = new User({
            email,
            cart: cart._id, // Associate the cart with the user
        });

        await user.save();
        return "User was created successfully!";
    } catch (error) {
        console.error("Error creating user:", error);
        throw new Error("An error occurred while creating user");
    }
};

const getUserCart = async (email) => {
    try {
        let user = await User.findOne({ email }).populate('cart');
        if (!user) {
            throw new Error("User not found");
        }

        if (!user.cart) {
            return [];
        }

        return user.cart.items;
    } catch (error) {
        console.error("Error getting cart products by email:", error);
        throw new Error("An error occurred while getting cart products by email");
    }
};

const checkUser = async (email) => {
    try {
        let user = await User.findOne({ email });
        if (!user) {
            await createUser(email);
        }

    } catch (error) {
        console.error("Error checking user:", error);
        throw new Error("An error occurred while checking user");
    }
};

module.exports = {
    getAllProducts,
    getStockReport,
    modifyCart,
    getProductsByCategory,
    createUser,
    getUserCart,
    checkUser,

};
