const express = require("express");
const router = express.Router();
const pool = require("../db");

// GET /api/find/stock-movements?movement_type=&reference=
router.get("/", async (req, res) => {
  const { movement_type, reference } = req.query;
  try {
    let query = `
      SELECT sm.id, sm.movement_type, sm.quantity, sm.reference, sm.created_at,
             s.id AS stock_id, COALESCE(r.name,p.name) AS item_name
      FROM stock_movements sm
      JOIN stock s ON sm.stock_id = s.id
      LEFT JOIN raw_materials r ON s.raw_material_id = r.id
      LEFT JOIN products p ON s.product_id = p.id
      WHERE 1=1
    `;
    const params = [];
    let idx = 1;

    if (movement_type) { query += ` AND sm.movement_type = $${idx}`; params.push(movement_type); idx++; }
    if (reference) { query += ` AND sm.reference ILIKE $${idx}`; params.push(`%${reference}%`); idx++; }

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { res.status(500).json({ error: err.message }); }
});

module.exports = router;
