const client = require(./db)
client.connect()

// buttons here
let addEmpBtn = document.getElementById('add');


// divs here
let addEmpForm = document.getElementById('addemployee');
addEmpForm.style.display = 'none';


function addEmployee() {
  if (addEmpForm.style.display === 'none') {
    document.getElementById('addemployee').style.display = 'block';
  }
}

function addEmployerSubmit() {

}

function updateEmployerSubmit() {}

function createW2Submit() {
    createW2Form.style.visibility = 'invisible';
    //const text = 'SELECT FROM '
    //const values = ['brianc', 'brian.m.carlson@gmail.com']
    // callback
    // client.query(text, values, (err, res) => {
    //   if (err) {
    //     console.log(err.stack)
    //   } else {
    //     console.log(res.rows[0])
    //     // { name: 'brianc', email: 'brian.m.carlson@gmail.com' }
    //   }
    // })
    createW2InfoDiv.style.visibility = 'visible';

}

function expenseReportSubmit() {
    expenseReportForm.style.visibility = 'invisible';
    expenseReportDiv.style.visibility = 'visible';
}

function addEmployeeSubmit() {}

function deleteEmployeeSubmit() {}

function updateEmployeeSubmit() {}
