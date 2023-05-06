const express = require('express');
const router = express.Router();

var connection = require('../services/database.js');

router.get('/', (req, res) => {
    const account = req.session.account;
    
    res.render('home', {account : account});
});

module.exports = router;
