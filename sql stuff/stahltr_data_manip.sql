-- Stahltr

-- TREVOR STAHL 10 21 2018 INTRODUCTION TO DATABASES (CS_340_400_F2018)


-- These are some Database Manipulation queries for a partially implemented Project Website 
-- using the bsg database.
-- Your submission should contain ALL the queries required to implement ALL the
-- functionalities listed in the Project Specs.

-- !!! Commented lines below often contain handlebars and variable place holders not applicable to pure SQL such as ${this.table}

-- `SELECT c_id FROM ${this.tableChars} WHERE b_id = :id`

-- INSERT INTO ${this.tableChars} ( b_id, c_id) VALUES ${charsSQL.join(',')};

-- 

-- INSERT INTO ${this.table} 
--            (name, p_id, gender, ipa_id, narrative, mp_id) 
--            VALUES(:name, :pantheon, :gender, :intraPantheon, :narrative, :metaPantheon)`;
			
-- UPDATE ${this.table} 
   --         SET 
     --           name = :name,
       --         p_id = :pantheon, 
         --       gender = :gender,
         --       ipa_id = :intraPantheon,
         --       narrative = :narrative, 
         --       mp_id = :metaPantheon
         --   WHERE ${this.idColumn} = :id;
			
			
-- INSERT INTO ${this.table} 
            -- (cname) VALUES(:cname);
			
-- UPDATE ${this.table} 
   --         SET 
     --           cname = :cname
       --     WHERE ${this.idColumn} = :id;
			
			
-- INSERT INTO ${this.table} 
           -- (ipname, p_id) VALUES(:ipname, :p_id);
		   
-- UPDATE ${this.table} SET  ipname = :ipname, p_id =  :p_id WHERE ${this.idColumn} = :id
			
-- SELECT * FROM ${this.table}


-- SELECT * FROM ${this.table} WHERE ${this.idColumn} = :id

-- DELETE FROM ${this.table} WHERE ${this.idColumn} = :id

-- INSERT INTO ${this.table} 
           -- (pname, loca) VALUES(:pname, :loca)
		   
-- INSERT INTO ${this.table} 
        --    (pname, loca) VALUES(:pname, :loca)
		
-- UPDATE ${this.table} 
          --  SET 
       --         pname = :pname,
        --        loca = :loca
        --    WHERE ${this.idColumn} = :id
		
		
-- !!! SQL below is primarily used for examplary purposes sql commented out above is used in my website within models


-- get all characteristics to populate dropdown window
SELECT c_id, cname FROM characteristics_tcs;

-- get all pantheons to populate dropdown window
SELECT p_id, pname FROM pantheons_tcs;

-- get all IPAs to populate dropdown window
SELECT ipa_id, ipname FROM ipas_tcs;

-- get all MPIDs to populate dropdown window
SELECT mp_id, name FROM mpids_tcs;

-- get all beings to populate dropdown window
SELECT b_id, name FROM beings_tcs;

-- get all beings where pantheon id equals to :pantheon_id
SELECT * FROM beings_tcs WHERE p_id = :pantheon_id;

-- add new characteristics
INSERT INTO characteristics_tcs (cname) VALUES (:cname);

-- add new pantheons
INSERT INTO pantheons_tcs (pname, loca) VALUES (:pname, :loca);
-- add new IPAs
INSERT INTO ipas_tcs (ipname, p_id) VALUES (:ipname, :p_id);
-- add new MPIDs
INSERT INTO mpids_tcs (name) VALUES (:name);

-- add new beings
INSERT INTO beings_tcs (name, p_id, gender, ipa_id, narrative, mp_id) VALUES (:name, :p_id, :gender, :ipa_id, :narrative, :mp_id);

-- attempt to remove a characteristics
DELETE FROM characteristics_tcs WHERE c_id = :characteristics_id;
-- attempt to remove pantheons
DELETE FROM pantheons_tcs WHERE p_id = :pantheon_id;
-- attempt to remove IPAs
DELETE FROM ipas_tcs WHERE ipa_id = :ipa_id;
-- attempt to remove MPIDs
DELETE FROM mpids_tcs WHERE mp_id = :meta_pantheon_id;
-- attempt to remove beings
DELETE FROM beings_tcs WHERE b_id = :being_id;

-- attempt to update being
UPDATE beings_tcs SET name = :name, gender= :gender WHERE b_id= :being_id;