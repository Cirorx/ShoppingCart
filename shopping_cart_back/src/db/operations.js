const Product = require("./models/product");

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

module.exports = {
    getAllProducts,
    getStockReport,
};
