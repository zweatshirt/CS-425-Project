
const exphbs = require('express-handlebars');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const crypto = require('crypto');
const path = require('path')
const express = require("express")

var app = express()
var logged_in = false;

// support url encoded bodies
app.use(bodyParser.urlencoded({ extended: true }));

// probably not necessary
app.use(cookieParser());

// engine needed for template engine    `
app.engine('hbs', exphbs({
    extname: '.hbs',
    layoutsDir:'views/layouts',
    defaultLayout:'index'
}));

app.set('view engine', 'hbs');
app.set('views', path.join(__dirname, '/views/layouts'));

app.get('/', function (req, res) {
    res.render('home',{
        topnav: {
            logged_in: logged_in
        }
    });
});

// called on user sign up form submit
app.get('/signup', (req, res) => {
    res.render('signup',{topnav: { logged_in: logged_in }});
});

//tried to get the about page working, didn't happen
app.get('/about', function (req, res) {
    res.render('about', {
        topnav: {
            logged_in: logged_in
        }
    });
});

// for hashing passwords
const getHashedPassword = (password) => {
    const sha256 = crypto.createHash('sha256');
    const hash = sha256.update(password).digest('base64');
    return hash;
}

// change to click from admin portal button
app.post('/signup', (req, res) => {
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
    // } else {
    //     res.render('signup', {
    //         message: 'Password does not match.',
    //         messageClass: 'alert-danger'
    //     });
    // }
});


app.listen(10000, function () {
console.log("Started application on port %d", 10000)
});
