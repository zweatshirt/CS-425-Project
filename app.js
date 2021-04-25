const express = require('express');
const exphbs = require('express-handlebars');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');

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
app.listen(10000, function () {
console.log("Started application on port %d", 10000)
});
