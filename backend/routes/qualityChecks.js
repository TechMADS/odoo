// routes/qualityChecks.js
const express = require("express");
const pool = require("../db");

const router = express.Router();

router.post("/", async (req, res) => {
  try {
    const { work_order_id, inspector_id, status, remarks } = req.body;
    const result = await pool.query(
      `INSERT INTO quality_checks (work_order_id, inspector_id, status, remarks)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [work_order_id, inspector_id, status, remarks]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get("/", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM quality_checks ORDER BY id ASC");
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get("/:id", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM quality_checks WHERE id=$1", [
      req.params.id,
    ]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
