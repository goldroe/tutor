const express = require('express');
const router = express.Router();

var connection = require('../services/database.js');

router.get('/', (req, res) => {
    const account = req.session.account;
    connection.query(`SELECT account.*, subject.*, favorite_list_id FROM favorite_list
    INNER JOIN account ON account.account_id = favorite_list.tutor_id
    INNER JOIN subject ON subject.subject_id = favorite_list.on_subject_id
    WHERE favorite_list.student_id = ${account.account_id};`, (err, rows) => {
        if (err) console.log(err);
        res.render('favorites', {account: account, favorites: rows});
    });
});

router.post('/', (req, res) => {
    const account = req.session.acccount;
    connection.query(`DELETE FROM favorite_list WHERE favorite_list_id = ${req.body.favorite_id}`, (err) => {
        if (err) console.log(err);
        res.redirect('favorites');
    });
});

module.exports = router;