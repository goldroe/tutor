const express = require('express');
const router = express.Router();

var connection = require('../services/database.js');

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

    let sql = `SELECT account.first_name, account.last_name, DATE(appointment.time_begin) AS date, TIME(appointment.time_begin) AS time_begin, TIME(appointment.time_end) AS time_end, subject.subject_name
    FROM appointment
    INNER JOIN subject ON subject.subject_id = appointment.subject_id
    INNER JOIN account ON `;
    
    if (account.account_type == 'student') {
        sql += `account.account_id = appointment.tutor_id `;
        sql += `WHERE appointment.student_id = ${account.account_id};`;
    } else {
        sql += `account.account_id = appointment.student_id `
        sql += `WHERE appointment.tutor_id = ${account.account_id};`;
    }

    connection.query(sql, (err, rows) => {
        if (err) throw err;
        // convert to standard (not military time)
        rows.forEach(function (element, index) {
            var start_split = rows[index].time_begin.split(":");
            var end_split = rows[index].time_end.split(":");
            let time_begin = start_split.slice(0, -1).join(':');
            let time_end = end_split.slice(0, -1).join(':');

            time_begin = convertMilitaryToStandard(time_begin);
            time_end = convertMilitaryToStandard(time_end);

            rows[index].time_begin = time_begin;
            rows[index].time_end = time_end;
        });

        res.render('appointment-view', {account: account, appointments: rows});
    });
});


router.post('/book', (req, res) => {
    console.log(req.body);
    const time_begin = req.body.time_begin;
    const time_end = req.body.time_end;
    const date = req.body.appointment_date;

    connection.query(`SELECT window_start, window_end FROM availabilities
    WHERE account_id = ${req.body.tutor_id}`, (err, rows) => {
        if (err) throw err;
        var window = rows[0];
        let start = time_begin + ":00";
        let end = time_end + ":00";
        let fits_window = start >= window.window_start && start < window.window_end && end > window.window_start && end <= window.window_end;

        if (fits_window) {
            var date_conflict = false;
            connection.query(`SELECT TIME(time_begin) AS time_begin, TIME(time_end) AS time_end FROM appointment
            WHERE tutor_id = ${req.body.tutor_id} AND DATE(time_begin)='${date}'`, (err, rows) => {
                if (err) throw err;
                for (let i = 0; i < rows.length; i++) {
                    let appointment_begin = rows[i].time_begin;
                    let appointment_end = rows[i].time_end;
                    if (time_begin < appointment_end && time_end > appointment_begin) {
                        date_conflict = true;
                        break;
                    }
                }

                if (!date_conflict) {
                    var date_begin = date + " " + time_begin + ":00";
                    var date_end = date + " " + time_end + ":00";
                    let duration = new Date(date_end) - new Date(date_begin);
                    duration = duration / 60 / 1000; // divides by milliseconds per minute
                    connection.query(`INSERT INTO appointment (subject_id, student_id, tutor_id, time_begin, time_end)
                    VALUES (${req.body.subject_id}, ${req.session.account.account_id}, ${req.body.tutor_id}, '${date_begin}', '${date_end}');`, (err, result, fields) => {
                        if (err) throw err;
                        connection.query(`UPDATE account SET tutoring_minutes = tutoring_minutes + ${duration} WHERE account_id = ${req.body.tutor_id} OR account_id = ${req.session.account.account_id};`, (err, result, fields) => {
                            if (err) throw err;
                            res.redirect('/appointments');
                        });
                    });
                } else {
                    res.redirect('/appointments');
                }
            });
        } else {
            res.redirect('/appointments');
        }
    });
});

module.exports = router;