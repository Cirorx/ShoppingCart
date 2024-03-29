const express = require('express');
const { getAllProducts, getStockReport,
    modifyCart, getProductsByCategory, checkUser, getUserCart, getProductById } = require('./operations');

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

router.get("/product/:id", async (req, res) => {
    const id = req.params.id;
    try {
        const products = await getProductById(id);
        res.json(products);
    } catch (error) {
        console.error("Error getting product by id: ", error);
        res.status(500).json({ error: "Error getting product by id" });
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

router.post("/cart", async (req, res) => {
    const { email } = req.body;
    try {
        const cartProducts = await getUserCart(email);
        res.json(cartProducts);
    } catch (error) {
        console.error("Error getting cart products by email:", error);
        res.status(500).json({ error: "Error getting cart products by email" });
    }
});

router.post("/check-user", async (req, res) => {
    const { email } = req.body;
    try {
        await checkUser(email);
        res.status(200).json({ message: "User exists" });
    } catch (error) {
        console.error("Error checking user:", error);
        res.status(500).json({ error: "An error occurred while checking user" });
    }
});



module.exports = router;
