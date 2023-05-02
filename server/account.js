const express = require('express');
const router = express.Router();

const connection = require('../services/database.js');

router.get('/', (req, res) => {
    // name, type, aboutme, hours, pfp
    connection.query(`SELECT account_id, account_type, first_name, last_name, avatar, about_me, tutoring_minutes / 60 AS tutoring_hours FROM account WHERE account_id=${req.session.account.account_id}`, (err, accounts) => {
        if (err) throw err;
        console.log(accounts);
        res.render('account', {account: accounts[0]});
    });
});

// router.post('/', (req, res) => {
//     const account = req.session.account;
//     res.render('update', {account : account});
// });


// router.post('/update', (req, res) => {
//     res.render('update', );
// });

module.exports = router;