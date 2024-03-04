require("dotenv").config();

const express = require("express");
const connectToDatabase = require("./src/db/connect");

const app = express();
const IP = process.env.IP;
const port = process.env.PORT || 3000;

const apis = require('./src/db/apis');

app.use(express.json());
app.use('/api', apis);

const start = async () => {
    try {
        console.log("Connecting to shopping_db...");
        await connectToDatabase(process.env.MONGO_URI);
        console.log("Starting server...");
        const server = app.listen(port, IP, () => {
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
