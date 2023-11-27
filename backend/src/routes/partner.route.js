const express = require('express');
const route = express.Router();

const partnerController = require('../controllers/partner.controller');

route.get('/', partnerController.list);
route.post('/create', partnerController.create);
route.post('/update', partnerController.update);
route.post('/delete', partnerController.delete);

module.exports = route;