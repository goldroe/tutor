const express = require('express');
const router = express.Router();

var connection = require('../services/database.js');

router.get('/', (req, res) => {
    const account = req.session.account;
    // get all tutor accounts
    connection.query(`SELECT account_id, first_name, last_name, avatar FROM account WHERE account_type='tutor'`, (err, tutors) => {
        if (err) console.log(err);
        else {
            // get all subjects of for each account
            connection.query(`SELECT account.account_id, subject_name, subject_description FROM subject_list
            INNER JOIN account ON account.account_id = subject_list.account_id
            INNER JOIN subject ON subject.subject_id = subject_list.subject_id;`, (err, subjects) => {
                if (err) console.log(err);
                res.render('tutors', {account: account, tutors: tutors});
            });
        }
    });
});

router.post('/', (req, res) => {
    const account = req.session.account;
    connection.query(`SELECT account_id, first_name, last_name, about_me, avatar, tutoring_minutes / 60 AS tutoring_hours FROM account WHERE account_id=${req.body.tutor_id}`, (err, rows) => {
        if (err) console.log(err);
        const tutor = rows[0];
        connection.query(`SELECT subject.subject_id, subject_name, subject_description FROM subject_list
        INNER JOIN subject ON subject.subject_id = subject_list.subject_id
        WHERE subject_list.account_id = ${tutor.account_id}`, (err, rows) => {
            if (err) console.log(err);
            const subjects = rows;
            res.render('tutor-view', {account: account, tutor: tutor, subjects: subjects});
        });
    });
});

router.post('/tutor', (req, res) => {
    const account = req.session.account;

    connection.query(`INSERT INTO favorite_list (student_id, tutor_id, on_subject_id)
    VALUES (${account.account_id}, ${req.body.tutor_id}, ${req.body.subject_id});`, (err) => {
        if (err) console.log(err);
        res.redirect('/favorites');
    });
});

module.exports = router;