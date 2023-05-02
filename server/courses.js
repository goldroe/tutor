const express = require('express');
const router = express.Router();

var connection = require('../services/database');

function convertMilitaryToStandard (time) {
    let timeParts = time.split(":");
    let standardTime = "";
  
    if (parseInt(timeParts[0]) > 12) {
      timeParts[0] = timeParts[0] - 12;
      standardTime = timeParts.join(":") + " PM";
    } else if (parseInt(timeParts[0]) === 12) {
      standardTime = timeParts.join(":") + " PM";
    } else {
      standardTime = timeParts.join(":") + " AM";
    }
  
    return standardTime;
  }

router.get('/', (req, res) => {
    const account = req.session.account;
    connection.query(`SELECT subject.*, account.account_id, account.first_name, account.last_name, account.email, account.avatar FROM subject INNER JOIN subject_list ON subject_list.subject_id = subject.subject_id INNER JOIN account ON account.account_id = subject_list.account_id`, (err, rows) => {
        if (err) throw err;
        const courses = rows;
        res.render('courses', {account: account, courses: courses});
    });
    
});

router.post('/', (req, res) => {
    console.log(req.body);


    connection.query(`SELECT window_start, window_end FROM availabilities
    WHERE account_id=${req.body.tutor_id}`, (err, rows) => {
        if (err) throw err;
        var start_split = rows[0].window_start.split(":");
        var end_split = rows[0].window_end.split(":");
        let window_start = start_split.slice(0, -1).join(':');
        let window_end = end_split.slice(0, -1).join(':');
        
        window_start = convertMilitaryToStandard(window_start);
        window_end = convertMilitaryToStandard(window_end);

        res.render('appointment', 
        {
            account: req.session.account, 
            tutor: {first_name: req.body.first_name, last_name: req.body.last_name, tutor_id: req.body.tutor_id},
            subject: {subject_id: req.body.subject_id, subject_name: req.body.subject_name},
            window_start: window_start, window_end: window_end
        });
    });
    
});

module.exports = router;