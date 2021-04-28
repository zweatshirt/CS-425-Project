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
var result=function result(){
    conn.query('SELECT NOW()', (err, res) => {
        console.log(err, res)
        conn.end()
      })
}

/*const ssn = document.querySelector('#ssn');
const password = document.querySelector('#password');
const signin = document.querySelector('#signin-container');

signin.addEventListener('submit', (e) => {
    e.preventDefault();

});*/
module.exports.query = result;