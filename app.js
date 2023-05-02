const express = require('express');
const exphbs = require('express-handlebars');
var session = require("express-session");
const multer  = require('multer');
const upload = multer();
const body_parser = require('body-parser');
const app = express();

const port = 5000;

var connection = require('./services/database.js');


var bcrypt = require('bcrypt');

app.use(body_parser.urlencoded({ extended: false }));
app.use(express.urlencoded({ extended: true })); //vvv
app.use(express.static("public"));

app.use(
    session({
        secret: "2C44-4D44L-W2iNpQ38T",
        resave: false,
        saveUninitialized: true,
        coookie: { secure : false }
    })
);

app.engine("hbs", exphbs.engine({extname: ".hbs"}));
app.set("view engine", "hbs");

app.use(express.urlencoded({ extended: false }));
app.use(express.json());

// static files
app.use(express.static('public')); 

// authentication
var auth = function(req, res, next) {
    if (req.session.account) {
        console.log('auth: logged in');
        return next();
    } else {
        console.log('auth: not logged in');
        return res.redirect('/login');
    }
};


app.get('/login', (req, res) => {
    console.log('sent to login');
    res.render('login');
});

app.post('/login', upload.none(), (req, res) => {
    connection.query(`SELECT account_id, first_name, last_name, account_type, avatar, email, password FROM account WHERE email='${req.body.email}';`, (err, rows) => {
        if (err) throw err;
        var account = rows[0];

        bcrypt.compare(req.body.pass, account.password, function(err, result) {
            if (result == true) {
                req.session.account = account;
                res.redirect('/'); // go to home page
            } else {
                res.redirect('/login');
            }
        });
    });
});

app.get('/logout', (req, res) => {
    console.log('logging out');
    delete req.session.account;
    res.redirect('/');
});

app.get('/about', (req, res) => {
    console.log('sent to about');
    res.render('about', {account: req.session.account});
});

const home = require('./server/home');
app.use('/', home);

const account = require('./server/account');
app.use('/account', auth, account);

const tutors = require('./server/tutors');
app.use('/tutors', tutors);

const register = require('./server/register');
app.use('/register', register);

const contact = require('./server/contact');
app.use('/contact', contact);

const courses = require('./server/courses');
app.use('/courses', courses);

const appointments = require('./server/appointments');
app.use('/appointments', auth, appointments);

const favorites = require('./server/favorites');
app.use('/favorites', auth, favorites);

app.listen(port, function (req, res) {
    console.log(`Now listening to port ${port}`);
});

