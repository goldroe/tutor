const express = require('express');
const multer  = require('multer');
const router = express.Router();
var bcrypt = require('bcrypt');

var storage = multer.diskStorage({  
    destination: function (req, file, callback) {  
        callback(null, 'public/images');  // maybe change path
    },  
    filename: function (req, file, callback) {  
        callback(null, file.originalname);  
    }  
});

var upload = multer({ storage : storage}).single('avatar');


var connection = require('../services/database.js');

router.get('/', (req, res) => {
    res.render('register');
});

// router.post('/', (req, res) => {
//     console.log(req.body);
    
//     upload(req, res, function(err) {
//         if (err) throw err;
        
//         console.log(req.body);
//         var account_type;
//         if (req.body.register == 'register as student') account_type = 'student';
//         else if (req.body.register == 'register as tutor') account_type = 'tutor';
        
//         connection.query(`INSERT INTO account (first_name, last_name, email, password, profile_picture, account_type) 
//         VALUES ('${req.body.first_name}', '${req.body.last_name}', '${req.body.email}', '${req.body.pass}', '${req.body.avatar}', '${account_type}')`, (err, rows) => {
//             if (err) throw err;
            
//             res.render('login');
//         });
//     });    
// });

router.get('/student', (req, res) => {
    res.render('register-student');
});

router.post('/student', (req, res) => {
    console.log(req.body);
    upload(req, res, function(err) {
        if (err) throw err;
        bcrypt.hash(req.body.pass, 10, function(err, hash) {
            if (err) throw err;
            connection.query(`INSERT INTO account (first_name, last_name, email, password, avatar, account_type, about_me) 
            VALUES ('${req.body.first_name}', '${req.body.last_name}', '${req.body.email}', '${hash}', '${req.file.filename}', 'student', '${req.body.about_me}')`, (err, result, fields) => {
                if (err) throw err;
                res.redirect('/login');
            });
        });
    });
});

router.get('/tutor', (req, res) => {
    connection.query(`SELECT * FROM subject`, (err, rows) => {
        res.render('register-tutor', {subjects: rows});
    });
});

router.post('/tutor', (req, res) => {
    console.log(req.body);
    upload(req, res, function(err) {
        if (err) throw err;
        bcrypt.hash(req.body.pass, 10, function(err, hash) {
            if (err) throw err;
            let subject_list = req.body.subject_list.split(',');

            connection.query(`INSERT INTO account (first_name, last_name, email, password, avatar, account_type, about_me) 
            VALUES ('${req.body.first_name}', '${req.body.last_name}', '${req.body.email}', '${hash}', '${req.file.filename}',   'tutor', '${req.body.about_me}')`, (err, result, fields) => {
                if (err) throw err;

                let account_id = result.insertId;

                let sql = `INSERT INTO subject_list (account_id, subject_id) VALUES `
                for (let i = 0; i < subject_list.length; i++) {
                    sql += `( ${account_id}, ${subject_list[i]} )`
                    if (i != subject_list.length - 1) {
                        sql += ', ';
                    }
                }

                connection.query(`${sql}; INSERT INTO availabilities (account_id, window_start, window_end)
                VALUES (${account_id}, '${req.body.window_start}', '${req.body.window_end}')`, (err, result, fields) => {
                    if (err) throw err;
                    res.redirect('/login');
                });
            });
        });
    });
});

module.exports = router;