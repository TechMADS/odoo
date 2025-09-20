const express = require("express");
const pool = require("../db");


const router = express.Router();

router.post('/', async (req, res) => {
  try {
    const { product_id, raw_material_id, quantity_required, unit } = req.body;
    const result = await pool.query(
      `INSERT INTO bill_of_materials (product_id, raw_material_id, quantity_required, unit)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [product_id, raw_material_id, quantity_required, unit]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM bill_of_materials ORDER BY id ASC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM bill_of_materials WHERE id=$1', [req.params.id]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
