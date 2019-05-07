'use strict';

const Database = require('./../lib/database');

class MasterModel {


    static get(filters = {}) {

        
        const where = [];
        const filterFields = Object.keys(filters);
        if(filterFields.length) {
            for(const key of filterFields) {
                where.push(`${key} =:${key}`);
            }
        }
        const statement = `SELECT * FROM ${this.table} WHERE ${where.length ? where.join(' AND ') : '1=1'}`;
        console.log(statement);
        return Database.query(statement, filters);

    }

    static getById(id) {

        const statement = `SELECT * FROM ${this.table} WHERE ${this.idColumn} = :id`;

        return Database.query(statement, { id })
            .then(rows => rows[0])

    }

    static delete(id) {
        const statement = `DELETE FROM ${this.table} WHERE ${this.idColumn} = :id`;
        
        return Database.query(statement, { id });
    }

}

module.exports = MasterModel;