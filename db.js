const { Client } = require('pg');
//make sure to change the credentials needed to sign into your db
var conn = new Client({
    user: 'postgres',
    host: '127.0.0.1',
    database: 'postgres',
    password: '1234abcd',
    port: 5432,
});

conn.connect();
module.exports