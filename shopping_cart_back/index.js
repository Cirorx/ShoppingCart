require("dotenv").config();

const express = require("express");
const connectToDatabase = require("./src/db/connect");
const { getAllProducts, getStockReport } = require("./src/db/operations");

const app = express();

const port = process.env.PORT || 3000;

app.get("/stock-report", async (req, res) => {
    try {
        const report = await getStockReport();
        res.json(report);
    } catch (error) {
        console.error("Error getting stock report:", error);
        res.status(500).json({ error: "Error getting stock report" });
    }
});

const start = async () => {
    try {
        console.log("Connecting to shopping_db...");
        await connectToDatabase(process.env.MONGO_URI);
        console.log("Starting server...");
        const server = app.listen(port, '127.0.0.1', () => {
            const address = server.address();
            const host = address.address;
            const port = address.port;
            console.log(`Server is running at http://${host}:${port}`);
        });
    } catch (e) {
        console.log(e);
    }
};



start();
