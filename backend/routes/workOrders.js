const express = require("express");
const pool = require("../db");

const router = express.Router();

router.post('/', async (req, res) => {
  try {
    const { manufacturing_order_id, task_name, assigned_to, status, start_time, end_time } = req.body;
    const result = await pool.query(
      `INSERT INTO work_orders (manufacturing_order_id, task_name, assigned_to, status, start_time, end_time)
       VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
      [manufacturing_order_id, task_name, assigned_to, status, start_time, end_time]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM work_orders ORDER BY id ASC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM work_orders WHERE id=$1', [req.params.id]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
