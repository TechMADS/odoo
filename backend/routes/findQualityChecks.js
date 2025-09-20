const express = require("express");
const router = express.Router();
const pool = require("../db");

// GET /api/find/quality-checks?status=&inspector=
router.get("/", async (req, res) => {
  const { status, inspector } = req.query;
  try {
    let query = `
      SELECT qc.id, qc.status, qc.remarks, qc.checked_at,
             wo.task_name, u.username AS inspector
      FROM quality_checks qc
      JOIN work_orders wo ON qc.work_order_id = wo.id
      JOIN users u ON qc.inspector_id = u.id
      WHERE 1=1
    `;
    const params = [];
    let idx = 1;

    if (status) { query += ` AND qc.status = $${idx}`; params.push(status); idx++; }
    if (inspector) { query += ` AND u.username ILIKE $${idx}`; params.push(`%${inspector}%`); idx++; }

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { res.status(500).json({ error: err.message }); }
});

module.exports = router;
