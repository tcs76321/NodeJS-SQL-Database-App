'use strict';

const express = require('express');
const model = require('./../models/beings');
const pantheonModel = require('./../models/pantheon');
const metaPantheonModel = require('./../models/meta-pantheons');
const intraPantheonModel = require('./../models/intra-pantheon');
const characteristicModel = require('./../models/characteristics');

const route = express.Router();

route.get('/', (req, res, next) => {

    const filters = {};


    if(req.query.metaPantheon) 
        filters.mp_id = req.query.metaPantheon;
    if(req.query.intraPantheon)
        filters.ipa_id = req.query.intraPantheon;
    if(req.query.pantheon)
        filters.p_id = req.query.pantheon;
    if(req.query.gender)
        filters.gender = req.query.gender;

    Promise.all([
            model.get(filters), 
            pantheonModel.get(),
            intraPantheonModel.get(),
            metaPantheonModel.get(),
            characteristicModel.get()
        ])
        .then(([beings, pantheons, intraPantheons, metaPantheons, characteristics]) => {
            res.render('beings', {
                beings,
                metaPantheons,
                intraPantheons,
                pantheons,
                characteristics
            });
        })
        .catch(next);

});

route.get('/:id', (req, res, next) => {
    
    Promise.all([
        model.getById(req.params.id),
        model.getCharsById(req.params.id),
        pantheonModel.get(),
        intraPantheonModel.get(),
        metaPantheonModel.get(),
        characteristicModel.get()
    ])
    .then(([being, beingChars, pantheons, intraPantheons, metaPantheons, characteristics]) => {
        console.log(beingChars);
        res.render('beings', {
            being,
            beingChars: beingChars.map(b => b.c_id),
            metaPantheons,
            intraPantheons,
            pantheons,
            characteristics
        });
    })
    .catch(next);

});

route.post('/', (req, res, next) => {

    model.insert(req.body)
        .then(() => res.redirect(req.originalUrl))
        .catch(next)
      
});

route.post('/:id', (req, res, next) => {

    model.update(req.body, req.params.id)
        .then(() => res.redirect(req.baseUrl || req.originalUrl))
        .catch(next);
});

route.delete('/:id', (req, res, next) => {

    model.delete(req.params.id)
        .then(() => res.json({ success: true }))
        .catch(next)
});

module.exports = route;