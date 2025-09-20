const express = require("express");
const router = express.Router();
const pool = require("../db");

// GET /api/find/work-orders?task_name=&status=&assigned_to=
router.get("/", async (req, res) => {
  const { task_name, status, assigned_to } = req.query;
  try {
    let query = `
      SELECT wo.id, wo.task_name, wo.status, u.username AS assigned_to, mo.id AS manufacturing_order_id, p.name AS product_name
      FROM work_orders wo
      JOIN users u ON wo.assigned_to = u.id
      JOIN manufacturing_orders mo ON wo.manufacturing_order_id = mo.id
      JOIN products p ON mo.product_id = p.id
      WHERE 1=1
    `;
    const params = [];
    let idx = 1;

    if (task_name) { query += ` AND wo.task_name ILIKE $${idx}`; params.push(`%${task_name}%`); idx++; }
    if (status) { query += ` AND wo.status = $${idx}`; params.push(status); idx++; }
    if (assigned_to) { query += ` AND u.username ILIKE $${idx}`; params.push(`%${assigned_to}%`); idx++; }

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { res.status(500).json({ error: err.message }); }
});

module.exports = router;
