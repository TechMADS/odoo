const express = require("express");
const pool = require("../db");

const router = express.Router();

router.post('/', async (req, res) => {
  try {
    const { name, sku, unit } = req.body;
    const result = await pool.query(
      `INSERT INTO raw_materials (name, sku, unit)
       VALUES ($1, $2, $3) RETURNING *`,
      [name, sku, unit]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM raw_materials ORDER BY id ASC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM raw_materials WHERE id=$1', [req.params.id]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;