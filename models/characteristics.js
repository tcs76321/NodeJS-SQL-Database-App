'use strict';

const Database = require('./../lib/database');
const MasterModel = require('./master');

class CharacteristicsModel extends MasterModel {

    static get table() {
        return 'characteristics_tcs';
    }

    
    static get idColumn() {
        return 'c_id';
    }


    static insert(characteristic) {

        const statement = `INSERT INTO ${this.table} 
            (cname) VALUES(:cname)`;

        return Database.query(statement, characteristic);

    }

    static update(characteristic, id) {

        const statement = `UPDATE ${this.table} 
            SET 
                cname = :cname
            WHERE ${this.idColumn} = :id`;

        return Database.query(statement,Object.assign({ id }, characteristic ));

    }

}

module.exports = CharacteristicsModel;