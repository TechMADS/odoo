const express = require("express");
const router = express.Router();
const pool = require("../db");

// GET /api/find/bill-of-materials?product_name=&component_name=
router.get("/", async (req, res) => {
  const { product_name, component_name } = req.query;
  try {
    let query = `
      SELECT bom.id, p.name AS product_name, r.name AS component_name, bom.quantity_required, bom.unit
      FROM bill_of_materials bom
      JOIN products p ON bom.product_id = p.id
      JOIN raw_materials r ON bom.raw_material_id = r.id
      WHERE 1=1
    `;
    const params = [];
    let idx = 1;

    if (product_name) { query += ` AND p.name ILIKE $${idx}`; params.push(`%${product_name}%`); idx++; }
    if (component_name) { query += ` AND r.name ILIKE $${idx}`; params.push(`%${component_name}%`); idx++; }

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { res.status(500).json({ error: err.message }); }
});

module.exports = router;
