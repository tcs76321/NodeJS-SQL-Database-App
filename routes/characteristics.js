'use strict';

const express = require('express');
const model = require('./../models/characteristics');

const route = express.Router();

route.get('/', (req, res, next) => {

    model.get()
        .then(characteristics => {
            res.render('characteristics', {
                characteristics
            });
        })
        .catch(next);
    
});

route.get('/:id', (req, res, next) => {

    model.getById(req.params.id)
        .then(characteristic => {
            res.render('characteristics', {
                characteristic
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