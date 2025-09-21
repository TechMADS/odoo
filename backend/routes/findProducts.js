const express = require("express");
const router = express.Router();
const pool = require("../db");

// GET /api/find/products?name=&sku=&product_type=
router.get("/", async (req, res) => {
  const { name, sku, product_type } = req.query;
  try {
    let query = "SELECT * FROM products WHERE 1=1";
    const params = [];
    let idx = 1;

    if (name) { query += ` AND name ILIKE $${idx}`; params.push(`%${name}%`); idx++; }
    if (sku) { query += ` AND sku ILIKE $${idx}`; params.push(`%${sku}%`); idx++; }
    if (product_type) { query += ` AND product_type = $${idx}`; params.push(product_type); idx++; }

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { res.status(500).json({ error: err.message }); }
});

module.exports = router;
