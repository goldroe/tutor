const express = require('express');
const router = express.Router();

var connection = require('../services/database.js');

router.get('/', (req, res) => {
    console.log('SESSION:\n', req.session);
    const account = req.session.account;
    
    res.render('home', {account : account});
});

module.exports = router;
