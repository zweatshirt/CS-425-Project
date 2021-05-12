var express = require('express');
var router = express.Router();
const db = require('./db');

router.get('/paycheck', function(req, res, next) {
    var salary='SELECT base_salary FROM "Employee"';
    db.query(salary, function (err, data, fields) {
    if (err) throw err;
    res.render('user-list', { title: 'salary', userData: data});
  });
});
module.exports = router;
