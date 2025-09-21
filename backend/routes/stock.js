const express = require("express");
const pool = require("../db");


const router = express.Router();

router.post('/', async (req, res) => {
  try {
    const { item_type, raw_material_id, product_id, quantity, location } = req.body;
    const result = await pool.query(
      `INSERT INTO stock (item_type, raw_material_id, product_id, quantity, location)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [item_type, raw_material_id, product_id, quantity, location]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM stock ORDER BY id ASC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM stock WHERE id=$1', [req.params.id]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
