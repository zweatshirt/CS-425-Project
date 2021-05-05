const { Client } = require('pg');

const config = {
    client: new Client({
        user: 'postgres',
        host: '127.0.0.1',
        database: 'postgres',
        password: '1234abcd',
        port: 5432,
    });
}

// connect after exporting
module.exports = config;
