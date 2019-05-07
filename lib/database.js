'use strict';

const mysql = require('mysql2/promise');

class Database {

    constructor() {

        this.conf = {
            host: process.env.DB_HOST || 'localhost',
            user: process.env.DB_USER || 'root',
            database: process.env.DB_NAME || 'project_a',
            password: process.env.DB_PASSWORD,
            port: 3306
        };
        
        this.pool = mysql.createPool(this.conf);
    }

    query(statement, placeholders) {

        let connection;
        return this.pool.getConnection()
            .then(connect => {
                connection = connect;

                connection.connection.config.namedPlaceholders = true;

                return connection.query(statement, placeholders);

                
            })
            .then(([rows]) => {
                connection.release();

                return rows;
            })
        
    }

}

module.exports = new Database();