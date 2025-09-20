import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import User from "../models/user.js";
import authConfig from "../config/auth.js";

export const register = async (req, res) => {
    try {
        const { role, name, email, password } = req.body;
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ error: "User already exists" });
        }
        const hashedPassword = await bcrypt.hash(password, 10);
        const user = new User({ role, name, email, password: hashedPassword });
        await user.save();
        return res.status(201).json({ message: "User registered successfully" });
    } catch (err) {
        return res.status(500).json({ error: "Server error" });
    }
};

export const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ error: "Invalid email or password" });
        }
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ error: "Invalid email or password" });
        }
        const token = jwt.sign({ id: user._id }, authConfig.secret, {
            expiresIn: authConfig.expiresIn,
        });
        return res.json({ success: true, token: token, user: { id: user._id, name: user.name, email: user.email } });
    } catch (err) {
        return res.status(500).json({ error: "Server error" });
    }
};