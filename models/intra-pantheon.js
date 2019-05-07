'use strict';

const Database = require('./../lib/database');
const MasterModel = require('./master');

class IntraPantheonModel extends MasterModel {

    static get table() {
        return 'ipas_tcs';
    }

    
    static get idColumn() {
        return 'ipa_id';
    }


    static insert(pantheon) {

        const statement = `INSERT INTO ${this.table} 
            (ipname, p_id) VALUES(:ipname, :p_id)`;

        return Database.query(statement, pantheon);

    }

    static update(pantheon, id) {

        const statement = `UPDATE ${this.table} 
            SET 
                ipname = :ipname,
                p_id =  :p_id
            WHERE ${this.idColumn} = :id`;

        return Database.query(statement, Object.assign({ id }, pantheon ));

    }
}

module.exports = IntraPantheonModel;