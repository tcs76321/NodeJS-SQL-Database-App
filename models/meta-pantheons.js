'use strict';

const Database = require('./../lib/database');
const MasterModel = require('./master');

class MetaPantheonModel extends MasterModel {

    static get table() {
        return 'mpids_tcs';
    }
    
    static get idColumn() {
        return 'mp_id';
    }

    static insert(pantheon) {

        const statement = `INSERT INTO ${this.table} 
            (name) VALUES(:name)`;

        return Database.query(statement, pantheon);

    }

    static update(pantheon, id) {

        const statement = `UPDATE ${this.table} 
            SET 
                name = :name
            WHERE ${this.idColumn} = :id`;

        return Database.query(statement, Object.assign({ id }, pantheon ));
    }

}

module.exports = MetaPantheonModel;