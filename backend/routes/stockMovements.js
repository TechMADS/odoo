const express = require("express");
const pool = require("../db");


const router = express.Router();

router.post('/', async (req, res) => {
  try {
    const { stock_id, movement_type, quantity, reference } = req.body;
    const result = await pool.query(
      `INSERT INTO stock_movements (stock_id, movement_type, quantity, reference)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [stock_id, movement_type, quantity, reference]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM stock_movements ORDER BY id ASC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM stock_movements WHERE id=$1', [req.params.id]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
