'use strict';

const express = require('express');
const model = require('./../models/pantheon');

const route = express.Router();

route.get('/', (req, res, next) => {

    model.get()
        .then(pantheons => {
            res.render('pantheons', {
                pantheons
            });
        })
        .catch(next);
    
});

route.get('/:id', (req, res, next) => {

    model.getById(req.params.id)
        .then(pantheon => {
            res.render('pantheons', {
                pantheon
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