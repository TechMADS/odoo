const express = require("express");
const router = express.Router();
const pool = require("../db");

// GET /api/find/manufacturing-orders?product_name=&status=&created_by=
router.get("/", async (req, res) => {
  const { product_name, status, created_by } = req.query;
  try {
    let query = `
      SELECT mo.id, p.name AS product_name, mo.order_quantity, mo.status, mo.created_at, u.username AS created_by
      FROM manufacturing_orders mo
      JOIN products p ON mo.product_id = p.id
      JOIN users u ON mo.created_by = u.id
      WHERE 1=1
    `;
    const params = [];
    let idx = 1;

    if (product_name) { query += ` AND p.name ILIKE $${idx}`; params.push(`%${product_name}%`); idx++; }
    if (status) { query += ` AND mo.status = $${idx}`; params.push(status); idx++; }
    if (created_by) { query += ` AND u.username ILIKE $${idx}`; params.push(`%${created_by}%`); idx++; }

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { res.status(500).json({ error: err.message }); }
});

module.exports = router;
