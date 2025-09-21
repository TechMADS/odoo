const express = require("express");
const cors = require("cors");
require("dotenv").config();

const app = express();
app.use(cors());
app.use(express.json());

app.use("/api/quality", require("./routes/qualityChecks"));

app.use("/api/products", require("./routes/products"));

app.use("/api/users", require("./routes/users"));

app.use("/api/manufacturing-orders", require("./routes/manufacturingOrders"));

app.use("/api/worker-orders", require("./routes/workOrders"));

app.use("/api/bom", require("./routes/billOfMaterial"));

app.use("/api/stock", require("./routes/stock"));

app.use("/api/raw-materials", require("./routes/rawMaterials"));

app.use("/api/stock-movements", require("./routes/stockMovements"));

app.use("/api/find-users",require("./routes/findUsers"));

app.use("/api/find-manufacturing-orders",require("./routes/findManufacturingOrders"));

app.use("/api/find-worker-orders",require("./routes/findWorkOrders"));

app.use("/api/find-bom",require("./routes/findBillOfMaterials"));

app.use("/api/find-stock",require("./routes/findStock"));

app.use("/api/find-stockmovements",require("./routes/findStockMovements"));

app.use("/api/find-qualitychecks",require("./routes/findQualityChecks"));

app.use('/api/find-raw-materials', require("./routes/findRawMaterials"));

app.use('/api/find-products', require("./routes/findProducts"));


const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
