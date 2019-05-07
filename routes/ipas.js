'use strict';

const express = require('express');
const model = require('./../models/intra-pantheon');
const pantheonModel = require('./../models/pantheon');

const route = express.Router();

route.get('/', (req, res, next) => {


    Promise.all([model.get(), pantheonModel.get()])
        .then(([intraPantheons, pantheons]) => {
            res.render('ipas', {
                intraPantheons,
                pantheons
            });
        })
        .catch(next);

});

route.get('/:id', (req, res, next) => {

    Promise.all([model.getById(req.params.id), pantheonModel.get()])
        .then(([intraPantheon, pantheons]) => {
            res.render('ipas', {
                intraPantheon,
                pantheons
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