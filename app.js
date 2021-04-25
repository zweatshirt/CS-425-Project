const express = require('express');
const exphbs = require('express-handlebars');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const crypto = require('crypto');

const express = require("express")
var app = express()

// support url encoded bodies
app.use(bodyParser.urlencoded({ extended: true }));

// probably not necessary
app.use(cookieParser());

// engine needed for authentication
app.engine('hbs', exphbs({
    extname: '.hbs'
}));

app.set('view engine', 'hbs');

app.get("/",function(request,response){
response.send("Hello World!")
})

app.get('/', function (req, res) {
    res.render('index');
});

// called on user sign up form submit
app.get('/signup', (req, res) => {
    res.render('signup');
});

// for hashing passwords
const getHashedPassword = (password) => {
    const sha256 = crypto.createHash('sha256');
    const hash = sha256.update(password).digest('base64');
    return hash;
}

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
        users.push({
            firstName,
            lastName,
            email,
            password: hashedPassword
        });

        res.render('signin', {
            message: 'Registration Complete. Please login to continue.',
            messageClass: 'alert-success'
        });
    } else {
        res.render('signup', {
            message: 'Password does not match.',
            messageClass: 'alert-danger'
        });
    }
});


app.listen(10000, function () {
console.log("Started application on port %d", 10000)
});
