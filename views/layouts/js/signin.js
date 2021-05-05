const client = require('../../../db')
client.connect()
function adminSignin(){
    var username=document.getElementById("adminsigninform").username
    var password=document.getElementById("adminsigninform").password
    var q='SELECT 1 FROM admin_user where user_email='+username+'and password='+password
    client.query(q,(err,res)=>{
        console.log(err,res);
        client.end()
    });
}
