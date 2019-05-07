'use strict';

require('dotenv').config();

const express = require("express");
const bodyParser = require('body-parser');
const handlebars = require('express-handlebars');

const beingsRoute = require('./routes/beings');
const pantheonsRoute = require('./routes/pantheons');
const metaPantheonsRoute = require('./routes/meta-pantheons');
const charsRoute = require('./routes/characteristics');
const ipasRoute = require('./routes/ipas');

const app = express();

const hbs = handlebars.create({ 
  defaultLayout: 'main',
  helpers: {
    eq: function(first, second, block) {
      return first == second ? block.fn(this) : block.inverse(this);
    },
    lookup: function(key, values = [], block) {
      console.log(values, key);
      return values.includes(key) ? block.fn(this) : block.inverse(this);
    }
  }
});

app.engine('handlebars', hbs.engine);
app.set('view engine', 'handlebars');
app.set('port', process.argv[2] || 4005);

app.use(express.static("public"));

app.use(bodyParser.urlencoded({ extended: true }));

app.use('/beings', beingsRoute);
app.use('/pantheons', pantheonsRoute);
app.use('/meta-pantheons', metaPantheonsRoute);
app.use('/chars', charsRoute);
app.use('/ipas', ipasRoute);

app.get('/', (req, res, next) => {
    res.render('index');
});

app.use((err, req, res, next) => {
  console.log(err);
  let message = 'An error ocurred';
  
  if(err.code === 'ER_NO_REFERENCED_ROW_2')
    message = 'Missing required field';

  if(err.code === 'ER_ROW_IS_REFERENCED_2')
    message = 'ERROR, foreign key constraints';

  res
    .status(500)
    .send(message);
});

app.listen(app.get('port'), () => {
  console.log('App listening on port: ', app.get('port'));
});