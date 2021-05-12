
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

// app.use('/paycheck', paycheck);

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

app.post('/updatek', (req, res) => {
    // need ssn
    console.log(req.body)
    const { ssn, contribution } = req.body;
    client.query('UPDATE "Employee" contribution = $2 WHERE ssn = $1',
                [ssn, contribution],(err1,res3)=>{
                console.log(err1,res3);
            });
    res.render('employeepage',{topnav:{logged_in:true}})
    // add taxbracket
});

app.post('/addemployee', (req, res) => {
    console.log(req.body)
    const { addemail, addemppassword, addssn,
            addempname, addjobtitle, salary,
            performance, cont, empstate,
            addempid,base_salary ,Manager,address} = req.body;
    client.query('INSERT INTO "Employee"(ssn,name,job_title,salary_type,performance,contribution,state,employer_id,email_address,is_manager,address,base_salary) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)',
                [addssn,addempname,addjobtitle,salary,performance,cont,empstate,addempid,addemail,Manager,address,base_salary],(err1,res3)=>{
                console.log(err1,res3);

            });
    client.query('INSERT INTO employee_user(user_email,password) VALUES($1::text,$2::text)',
        [addemail,addemppassword],(err,res2)=>{
        console.log(err,res2);

    });

    res.render('adminpage',{topnav:{logged_in:true}})
    // add taxbracket
});

app.post('/updateemployee', (req, res) => {
    console.log(req.body)
    const { updateemail, updateemppassword, updatessn,
        updateempname, updatejobtitle, updatesalary,
            updateperformance, updatecont, updateempstate,
            updateempid,updatebase_salary ,updateManager,updateaddress} = req.body;
    client.query('UPDATE "Employee" set ssn = $1,name = $2,job_title = $3,salary_type = $4,performance = $5,contribution = $6,state = $7,employer_id = $8,email_address = $9,is_manager = $10,address = $11,base_salary = $12 WHERE ssn = $1',
                [updatessn,updateeempname,updatejobtitle,updatesalary,updateeperformance,updatecont,updateempstate,updateempid,updateemail,updateManager,updateaddress,updatebase_salary],(err1,res3)=>{
                console.log(err1,res3);
            });
    client.query('INSERT IGNORE INTO employee_user(user_email,password) VALUES($1::text,$2::text)',
        [updateemail,updateemppassword],(err,res2)=>{
        console.log(err,res2);

    });

    res.render('adminpage',{topnav:{logged_in:true}})
    // add taxbracket
});



app.post('/deleteemployee', (req, res) =>{
    const{ addemail ,
    } =req.body;
    console.log(addemail);

    client.query('DELETE FROM employee_user WHERE user_email = $1::text',[addemail]);
    client.query('DELETE FROM "Employee" WHERE email_address = $1::text', [addemail]);
    res.render('adminpage', { topnav: { logged_in: true } })
});



//adding an employer
app.post('/addemployer', (req, res) => {
    console.log(req.body)
    const { employerid, companyname, companysale,
        insuranceprem, contriMatch} = req.body;
    client.query('INSERT INTO "Employer"(employer_id, company_sale, insurance_premium_contribution, "401k_company_match", name) VALUES($1,$2,$3,$4,$5)',
        [employerid, companysale, insuranceprem, contriMatch, companyname], (err1, res3) => {
            console.log(err1, res3);

        });
    res.render('adminpage', { topnav: { logged_in: true } })

}
);

//adding a dependent on employeepage once logged in.
    app.post('/addDependent', (req, res) =>{
        console.log(req.body)
        const { employeeSSN, dependentname, dependentSSN, dependentrelation} = req.body;

        client.query('INSERT INTO "Dependent"(ssn, dependent_ssn, name, relation ) VALUES($1, $2, $3, $4)', [employeeSSN, dependentSSN, dependentname, dependentrelation], (err1, res3) =>{
            console.log(err1, res3);
        });

        res.render('employeepage', {
            topnav: { logged_in: true }
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

// called on user sign in form submit
app.post('/signinchecked', (req, res) => {
    const { email, password } = req.body;
    console.log(email)
    client.query('SELECT 1 FROM employee_user where user_email=$1::text and password=$2::text', [email, password], (err, res2) => {
        console.log(err, res);
        if (res2.rowCount === 1) {
            res.render('employeepage', {
                topnav: { logged_in: true }
            });
        }else{
            res.render('signin', {
                topnav: {
                    logged_in: false
                }
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
app.post('/signup', (req, res) => {
    const { email, password, name, ssn } = req.body;

    // Check if the password and confirm password fields match
    //if (password === confirmPassword) {

        // Check if user with the same email is also registered
        // fix to check db
        // if (users.find(user => user.email === email)) {
        //
        //     res.render('register', {
        //         message: 'User already registered.',
        //         messageClass: 'alert-danger'
        //     });
        //
        //     return;
        // }

        // const hashedPassword = getHashedPassword(password);

        // switch to store user in db
        // users.push({
        //     firstName,
        //     lastName,
        //     email,
        //     password: hashedPassword
        // });

        client.query('INSERT INTO "Employee"(ssn,name,email_address) VALUES($1,$2,$3)',
                    [ssn,name,email],(err1,res3)=>{
                    console.log(err1,res3);

                });
        client.query('INSERT INTO employee_user(user_email,password) VALUES($1::text,$2::text)',
            [email,password],(err,res2)=>{
            console.log(err,res2);
        });
        res.render('signin', {
            message: 'Registration Complete. Please login to continue.',
            messageClass: 'alert-success'
        });
    //}// else {
    //     res.render('signup', {
    //         message: 'Password does not match.',
    //         messageClass: 'alert-danger'
    //     });
    // }
    //NEED TO ADD employee portal
});


app.listen(10000, function () {
console.log("Started application on port %d", 10000)
});
