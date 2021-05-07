
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
            name, title, salary,
            perf, cont, state,
            id,base_salary ,is_manager,address} = req.body;
    console.log(email)
    client.query('INSERT INTO employee_user(user_email,password) VALUES(user_email=$1::text and password=$2::text)',
        [email,password],(err,res2)=>{
        console.log(err,res2);
    });
    client.query(
        'INSERT INTO employee(ssn,name,job_title,salary_type,performance,401k_contribution,state,employer_id,email_address,is_manager,address,base_salary) \
        VALUES(ssn=$1::text and name=$2::text and title=$3::text and state=$4::text and employer_id=$5::text and 401k_contribution=$6::text and salary_type=$7::text and performance=$8::text and \
        base_salary=base_salary::text,email_address=email::text,is_manager=is_manager::text,address=address::text)',
        [ssn,name,title,state,id,cont,salary,perf,base_salary,email,is_manager,address],(err1,res3)=>{
        console.log(err1,res3);
    });
    // add taxbracket
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
