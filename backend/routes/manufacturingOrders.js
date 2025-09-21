const express = require("express");
const pool = require("../db");

const router = express.Router();

router.post('/', async (req, res) => {
  try {
    const {
      product_id,
      order_quantity,
      status,
      units,
      states,
      created_by,
      due_date,
    } = req.body;

    // Validate inputs
    if (!product_id || !order_quantity || !status || !created_by) {
      return res.status(400).json({ error: "Missing required fields" });
    }

    const result = await pool.query(
      `INSERT INTO manufacturing_orders 
      (product_id, order_quantity, status, created_by, due_date, units, states, created_at)
       VALUES ($1, $2, $3, $4, $5, $6, $7, NOW()) RETURNING *`,
      [product_id, order_quantity, status, created_by, due_date || null, units || 'null', states || null]
    );

    res.json(result.rows[0]);
  } catch (err) {
    console.error(err); // log the full error
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
