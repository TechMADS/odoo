const express = require("express");
const router = express.Router();
const pool = require("../db");

// GET /api/find/users?username=&email=&role=
router.get("/", async (req, res) => {
  const { username, email, role } = req.query;
  try {
    let query = "SELECT id, username, full_name, email, role, created_at FROM users WHERE 1=1";
    const params = [];
    let idx = 1;

    if (username) { query += ` AND username ILIKE $${idx}`; params.push(`%${username}%`); idx++; }
    if (email) { query += ` AND email ILIKE $${idx}`; params.push(`%${email}%`); idx++; }
    if (role) { query += ` AND role = $${idx}`; params.push(role); idx++; }

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) { res.status(500).json({ error: err.message }); }
});

module.exports = router;
