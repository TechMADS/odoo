const express = require("express");
const router = express.Router();
const pool = require("../db");

// GET /api/find/raw-materials?name=&sku=
router.get("/", async (req, res) => {
  const { name, sku } = req.query;
  try {
    let query = "SELECT * FROM raw_materials WHERE 1=1";
    const params = [];
    let idx = 1;

    if (name) { query += ` AND name ILIKE $${idx}`; params.push(`%${name}%`); idx++; }
    if (sku) { query += ` AND sku ILIKE $${idx}`; params.push(`%${sku}%`); idx++; }

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { res.status(500).json({ error: err.message }); }
});

module.exports = router;
