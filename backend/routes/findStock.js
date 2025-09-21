const express = require("express");
const router = express.Router();
const pool = require("../db");

// GET /api/find/stock?item_name=&item_type=
router.get("/", async (req, res) => {
  const { item_name, item_type } = req.query;
  try {
    let query = `
      SELECT s.id, s.item_type, s.quantity, s.location,
             COALESCE(r.name, p.name) AS item_name
      FROM stock s
      LEFT JOIN raw_materials r ON s.raw_material_id = r.id
      LEFT JOIN products p ON s.product_id = p.id
      WHERE 1=1
    `;
    const params = [];
    let idx = 1;

    if (item_name) { query += ` AND COALESCE(r.name,p.name) ILIKE $${idx}`; params.push(`%${item_name}%`); idx++; }
    if (item_type) { query += ` AND s.item_type = $${idx}`; params.push(item_type); idx++; }

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { res.status(500).json({ error: err.message }); }
});

module.exports = router;
