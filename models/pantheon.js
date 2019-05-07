'use strict';

const Database = require('./../lib/database');
const MasterModel = require('./master');

class PantheonModel extends MasterModel {

    static get table() {
        return 'pantheons_tcs';
    }

    
    static get idColumn() {
        return 'p_id';
    }


    static insert(pantheon) {

        const statement = `INSERT INTO ${this.table} 
            (pname, loca) VALUES(:pname, :loca)`;

        return Database.query(statement, pantheon);

    }

    
    static update(pantheon, id) {

        const statement = `UPDATE ${this.table} 
            SET 
                pname = :pname,
                loca = :loca
            WHERE ${this.idColumn} = :id`;

        return Database.query(statement, Object.assign({ id }, pantheon ));

    }
    

}

module.exports = PantheonModel;