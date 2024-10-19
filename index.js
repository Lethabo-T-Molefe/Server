const express = require("express");
const cors = require("cors");
const AuthRoute = require("./routes/auth.routes");

const app = express();

app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(cors({ origin: "*" }));
app.listen(3001);


app.use("/api/auth", AuthRoute);

app.get("/", (req, res) => {
  return res.status(200).json({ message: req.body.message });
});
