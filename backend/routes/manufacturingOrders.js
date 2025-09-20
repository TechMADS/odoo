const express = require("express");
const pool = require("../db");

const router = express.Router();

router.post('/', async (req, res) => {
  try {
    const { product_id, order_quantity, status, created_by, due_date } = req.body;
    const result = await pool.query(
      `INSERT INTO manufacturing_orders (product_id, order_quantity, status, created_by, due_date)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [product_id, order_quantity, status, created_by, due_date]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM manufacturing_orders ORDER BY id ASC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM manufacturing_orders WHERE id=$1', [req.params.id]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
