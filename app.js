
const exphbs = require('express-handlebars');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const crypto = require('crypto');
const path = require('path')
const express = require("express");
const { get } = require('http');
const client = require('./db')
client.connect()
var app = express()
var logged_in = false;

// support url encoded bodies
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('views/layouts/'))

// engine needed for template engine    `
app.engine('hbs', exphbs({
    extname: '.hbs',
    layoutsDir:'views/layouts',
    defaultLayout:'index'
}));

app.set('view engine', 'hbs');
app.set('views', path.join(__dirname, '/views/layouts/'));

app.get('/', function (req, res) {
    res.render('home',{
        topnav: {
            logged_in: logged_in
        }
    });
});
app.get('/adminsignin',(req,res) => {
    res.render('adminsignin',{topnav: { logged_in: logged_in }})
})

app.get('/signin', (req, res) => {
    res.render('signin'),{topnav: { logged_in: logged_in }}

})

app.post('/addemployee', (req, res) => {
    const { email, password, ssn,
            first, last, title,
            state, cont } = req.body;
    console.log(email)

    client.query('INSERT INTO employee_user(user_email,password) VALUES(user_email=$1::text and password=$2::text)',
        [email,password],(err,res2)=>{
        console.log(err,res2);
    });
    client.query('INSERT INTO employee(ssn,first,last,title,state,cont)',
        [ssn,first,last,title,state,cont],(err,res2)=>{
        console.log(err,res2);
    });
});

// called on user sign up form submit
app.post('/signinchecked', (req, res) => {
    const { email, password } = req.body;
    console.log(email)
    client.query('SELECT 1 FROM employee_user where user_email=$1::text and password=$2::text',[email,password],(err,res2)=>{
        console.log(err,res);
        if (res2.rowCount === 1) {
            res.render('employeepage', {
                topnav: { logged_in: true }
            });
        }
    });
    res.render('employeepage',{
        topnav: {
            logged_in: logged_in
        }
    });
});

//tried to get the about page working, didn't happen
app.get('/about', function (req, res) {
    res.render('about', {
        topnav: {
            logged_in: logged_in
        }
    });
});
app.post('/admincheck',(req,res)=>{
    const { email, password } = req.body;
    console.log(email)
    client.query('SELECT 1 FROM admin_user where user_email=$1::text and password=$2::text',[email,password],(err,res2)=>{
        if (res2.rowCount === 1) {
            res.render('adminpage', {
                topnav: { logged_in: true }
            });
        }else{
            res.render('adminsignin', {
            topnav: { logged_in: false }
        });
    }

    });

});
// for hashing passwords
const getHashedPassword = (password) => {
    const sha256 = crypto.createHash('sha256');
    const hash = sha256.update(password).digest('base64');
    return hash;
}
app.get('/signout',(req,res) => {
    res.render('home',{
        topnav: { logged_in: false }
    });
})
app.get('/signup',(req,res) => {
    res.render('signup',{
        topnav: { logged_in: false }
    });
})
// change to click from admin portal button
app.get('/signupchecked', (req, res) => {
    const { ssn, first, last, password, passwordConfirm } = req.body;

    // Check if the password and confirm password fields match
    if (password === confirmPassword) {

        // Check if user with the same email is also registered
        // fix to check db
        if (users.find(user => user.email === email)) {

            res.render('register', {
                message: 'User already registered.',
                messageClass: 'alert-danger'
            });

            return;
        }

        const hashedPassword = getHashedPassword(password);

        // switch to store user in db
        // users.push({
        //     firstName,
        //     lastName,
        //     email,
        //     password: hashedPassword
        // });


        res.render('signin', {
            message: 'Registration Complete. Please login to continue.',
            messageClass: 'alert-success'
        });
    }// else {
    //     res.render('signup', {
    //         message: 'Password does not match.',
    //         messageClass: 'alert-danger'
    //     });
    // }
});


app.listen(10000, function () {
console.log("Started application on port %d", 10000)
});
