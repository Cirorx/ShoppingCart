const express = require('express');
const { getAllProducts, getStockReport,
    modifyCart, getProductsByCategory, createUser, getUserCart } = require('./operations');

const router = express.Router();

router.get("/stock-report", async (req, res) => {
    try {
        const report = await getStockReport();
        res.json(report);
    } catch (error) {
        console.error("Error getting stock report:", error);
        res.status(500).json({ error: "Error getting stock report" });
    }
});

router.get("/products", async (req, res) => {
    try {
        const report = await getAllProducts();
        res.json(report);
    } catch (error) {
        console.error("Error getting products:", error);
        res.status(500).json({ error: "Error getting products" });
    }
});


router.post("/modify-cart", async (req, res) => {
    const userEmail = req.body.userEmail;
    const productId = req.body.productId;
    const quantity = req.body.quantity;

    try {
        const result = await modifyCart(userEmail, productId, quantity);
        res.send(result);
    } catch (error) {
        console.error("Error modifying cart:", error);
        res.status(500).send("An error occurred while modifying the cart");
    }
});

router.get("/products/category/:category", async (req, res) => {
    const category = req.params.category;
    try {
        const products = await getProductsByCategory(category);
        res.json(products);
    } catch (error) {
        console.error("Error getting products by category:", error);
        res.status(500).json({ error: "Error getting products by category" });
    }
});

router.post("/create-user", async (req, res) => {
    const { email } = req.body;
    try {
        const result = await createUser(email);
        res.send(result);
    } catch (error) {
        console.error("Error creating user:", error);
        res.status(500).json({ error: "An error occurred while creating user" });
    }
});

router.get("/cart/:email", async (req, res) => {
    const email = req.params.email;
    try {
        const cartProducts = await getUserCart(email);
        res.json(cartProducts);
    } catch (error) {
        console.error("Error getting cart products by email:", error);
        res.status(500).json({ error: "Error getting cart products by email" });
    }
});



module.exports = router;
