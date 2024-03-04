const express = require('express');
const { getAllProducts,
    getStockReport,
    modifyCart, } = require('./operations');

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
    const userId = req.body.userId;
    const productId = req.body.productId;
    const quantity = req.body.quantity;

    try {
        const result = await modifyCart(userId, productId, quantity);
        res.send(result);
    } catch (error) {
        console.error("Error modifying cart:", error);
        res.status(500).send("An error occurred while modifying the cart");
    }
});



module.exports = router;
