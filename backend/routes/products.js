// routes/products.js
const express = require("express");
const pool = require("../db");

const router = express.Router();

// POST - create product
router.post("/", async (req, res) => {
  try {
    const { name, sku, product_type, unit } = req.body;
    const result = await pool.query(
      `INSERT INTO products (name, sku, product_type, unit)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [name, sku, product_type, unit]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET - all products
router.get("/", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM products ORDER BY id ASC");
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET - product by id
router.get("/:id", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM products WHERE id=$1", [
      req.params.id,
    ]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
