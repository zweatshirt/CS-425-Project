const { Client } = require('pg');

const client = new Client({
    user: 'postgres',
    host: 'localhost',
    database: 'testdb',
    password: '1234abcd',
    port: 5432,
});

client.connect();


const ssn = document.querySelector('#ssn');
const password = document.querySelector('#password');
const signin = document.querySelector('#signin-container');

signin.addEventListener('submit', (e) -> {
    e.preventDefault();

});
