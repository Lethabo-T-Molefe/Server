const express = require("express");
const router = express.Router();
const { userLogin } = require('../controller/auth.controller');

router.post('/login', userLogin);

module.exports = router;