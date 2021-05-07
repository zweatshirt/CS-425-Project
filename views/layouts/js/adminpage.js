let addEmpBtn = document.getElementById('add');
let deleteEmpBtn = document.getElementById('delete');
let updateEmpBtn = document.getElementById('updateemployee');
let reportBtn = document.getElementById('report');
let addEmployerBtn = document.getElementById('addeemployer');
let updateEmployerBtn = document.getElementById('updateEmployerBtn');
let createW2Button = document.getElementById('createw2');


let addEmpForm = document.getElementById('addemployee');
addEmpForm.style.display = "none";
let deleteEmpForm = document.getElementById('deleteemployee');
deleteEmpForm.style.display = "none";

// on 'Add new employee.' btn click
function addEmployee() {
  if (addEmpForm.style.display === 'none') {
    addEmpForm.style.display = 'block';
  }
  else addEmpForm.style.display = 'none';
}

function deleteEmployee() {
  if (deleteEmpForm.style.display === 'none') {
    deleteEmpForm.style.display = 'block';
  }
  else deleteEmpForm.style.display = 'none';
}
