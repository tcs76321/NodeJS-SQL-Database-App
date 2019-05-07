'use strict';

const Database = require('./../lib/database');
const MasterModel = require('./master');

class BeingsModel extends MasterModel {

    static get table() {
        return 'beings_tcs';
    }

    static get tableChars() {
        return 'ilr_tcs';
    }

    static get idColumn() {
        return 'b_id';
    }

    static getCharsById(id) {
        return Database.query(`SELECT c_id FROM ${this.tableChars} WHERE b_id = :id`, { id });
    }

    static insert(being) {

        const statement = `INSERT INTO ${this.table} 
            (name, p_id, gender, ipa_id, narrative, mp_id) 
            VALUES(:name, :pantheon, :gender, :intraPantheon, :narrative, :metaPantheon)`;

        being.metaPantheon = !being.metaPantheon ? null : being.metaPantheon;
        being.intraPantheon = !being.intraPantheon ? null : being.intraPantheon;

        return Database.query(statement, being)
            .then(result => {

               return this.insertChars(being.characteristics, result.insertId);
            })

    }

    static insertChars(characteristics, id) {

        if(!characteristics || !characteristics.length)
            return id;

        characteristics = Array.isArray(characteristics) ? characteristics : [characteristics];
        
        const charsPlaceholders = {
            id
        };

        const charsSQL = characteristics.map((char, index) => {
            charsPlaceholders[`char_${index}`] = char;
            return `(:id, :char_${index} )`;
        })

        const charStatement = `INSERT INTO ${this.tableChars} 
        ( b_id, c_id) 
        VALUES ${charsSQL.join(',')};`

        return Database.query(charStatement, charsPlaceholders);
    }

    static deleteChars(id) {
        const charStatement = `DELETE FROM ${this.tableChars} WHERE b_id = :id;`

        return Database.query(charStatement, { id });
    }

    static update(being, id) {

        const statement = `UPDATE ${this.table} 
            SET 
                name = :name,
                p_id = :pantheon, 
                gender = :gender,
                ipa_id = :intraPantheon,
                narrative = :narrative, 
                mp_id = :metaPantheon
            WHERE ${this.idColumn} = :id`;

        being.metaPantheon = !being.metaPantheon ? null : being.metaPantheon;
        being.intraPantheon = !being.intraPantheon ? null : being.intraPantheon;

        return Database.query(statement, Object.assign({ id }, being ))
            .then(() => this.deleteChars(id))
            .then(() => this.insertChars(being.characteristics, id))
            
    }

}

module.exports = BeingsModel;