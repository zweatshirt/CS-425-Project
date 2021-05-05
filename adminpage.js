const client = require(./db)
client.connect()

const addEmpBtn = document.getElementById('addemployee')
const delEmpBtn = document.getElementById('deletemployee')
const updateEmployeeBtn = document.getElementById('updateemployee')
const updateEmployerBtn = document.getElementById('updateemployer')
const reportBtn = document.getElementById('report')
const createW2Btn = document.getElementById('createw2')
const addEmployerForm = document.getElementById('addemployer-1')
const addEmployeeForm = document.getElementById('addemployee')
const updateEmployerForm = document.getElementById('updateemployer-1')
const updateEmployeeForm = document.getElementById('updateemployee-1')
const createW2Form = document.getElementById('createw2-1')
const createW2InfoDiv = document.getElementById('createw2-2')
const expenseReportForm = document.getElementById('expensereport-1')
const expenseReportDiv = document.getElementById('expensereport-2')
const updateEmployeeForm = document.getElementById('updateemployee-1')
const deleteEmployeeForm = document.getElementById('deleteemployee')

addEmpBtn.onclick = function() {
    addEmployeeForm.style.visibility = 'visible';
}

delEmpBtn.onclick = function() {
    deleteEmployeeForm.style.visibility = 'visible';
}

updateEmpBtn.onclick = function() {
    updateEmployeeForm.style.visibility = 'visible';
}

reportBtn.onclick = function() {
    expenseReportForm.style.visibility = 'visible';
}

addEmpBtn.onclick = function() {
    addEmployerForm.style.visibility = 'visible';
}

updateEmpBtn.onclick = function() {
    updateEmployerForm.style.visibility = 'visible';
}
createW2Btn.onclick = function() {
    createW2Form.style.visibility = 'visible';
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
