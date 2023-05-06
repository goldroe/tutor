const mysql = require('mysql');

let connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'Tutor',
    multipleStatements: true,
    dateStrings: true,
    port: 3306
});

connection.connect(function(err) {
    if (err) console.log(err);
});

module.exports = connection;
