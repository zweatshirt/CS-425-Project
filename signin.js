const { Client } = require('pg');
//make sure to change the credentials needed to sign into your db
const client = new Client({
    user: 'postgres',
    host: 'localhost',
    database: 'postgres',
    password: '1234abcd',
    port: 5432,
});

await client.connect();


const ssn = document.querySelector('#ssn');
const password = document.querySelector('#password');
const signin = document.querySelector('#signin-container');

signin.addEventListener('submit', (e) => {
    e.preventDefault();

});
