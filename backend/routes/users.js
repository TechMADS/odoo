const express = require("express");
const bcryptjs=require("bcryptjs");

const router = express.Router();

const pool = require("../db");

// Get all users
router.get("/", async (req, res) => {
  try {
    const result = await pool.query("SELECT id, username, full_name, email, role, created_at FROM users");
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Create user
router.post("/", async (req, res) => {
  const { username, full_name, email, role, password } = req.body;

  if (!password) {
    return res.status(400).json({ error: "Password is required" });
  }

  try {
    // Hash password
    const saltRounds = 10;
    const passwordHash = await bcryptjs.hash(password, saltRounds);

    const result = await pool.query(
      `INSERT INTO users (username, full_name, email, role, password_hash)
       VALUES ($1,$2,$3,$4,$5)
       RETURNING id, username, full_name, email, role, created_at`,
      [username, full_name, email, role, passwordHash]
    );

    // ✅ Return user without password_hash
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// Login route (check password)
router.post("/login", async (req, res) => {
  const { email, password } = req.body;
  try {
    const result = await pool.query("SELECT * FROM users WHERE email=$1", [email]);
    if (result.rows.length === 0) {
      return res.status(400).json({ error: "User not found" });
    }

    const user = result.rows[0];

    const validPassword = await bcrypt.compare(password, user.password_hash);
    if (!validPassword) {
      return res.status(401).json({ error: "Invalid password" });
    }

    // Don’t return the hash in response
    res.json({
      message: "Login successful",
      user: { id: user.id, username: user.username, email: user.email, role: user.role }
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
