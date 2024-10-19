const bcrypt = require("bcrypt");
const db = require("../config/config");
const jwt = require("jsonwebtoken");
const { secret_key } = require("../config/auth");

const userLogin = async (req, res) => {
  try {
    let { email, password } = req.body;
    let type = "";

    let [result] = await db.execute("SELECT * from admin WHERE email = ?", [
      email,
    ]);

    if (result.length > 0) {
      type = "admin";
    } else {
      [result] = await db.execute("SELECT * FROM organiser WHERE email = ?", [
        email,
      ]);
      if (result.length > 0) {
        type = "organiser";
      }
    }

    console.log("Here ", type);
    if (type.length > 0) {
      const isValid = await bcrypt.compare(password, result[0].password);
      if (isValid === true) {
        const token = jwt.sign({}, secret_key);
        return res.status(200).json({
          token,
          type,
          result,
        });
      }
    }

    return res.status(403).json({ message: "Invalid Credentials" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

module.exports = { userLogin };