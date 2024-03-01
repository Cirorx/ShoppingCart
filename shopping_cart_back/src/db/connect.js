const mongoose = require("mongoose");

mongoose.set("strictQuery", false);

const connectToDatabase = async (url) => {
    try {
        await mongoose.connect(url, {
            dbName: 'shopping_db',
        });
        console.log("Connection successful!");
    } catch (error) {
        console.error("There was an error trying to connect:", error);
        process.exit(1);
    }
};

module.exports = connectToDatabase;