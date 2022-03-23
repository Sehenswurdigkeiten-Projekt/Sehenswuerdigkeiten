const express = require("express")
const app = express()

var bodyParser = require('body-parser')

var bcrypt = require('bcryptjs');
var jsonParser = bodyParser.json()
var urlencodedParser = bodyParser.urlencoded({ extended: false })

var mysql = require('mysql')
var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    port: "3306",
    password: "12345678"
  });
  
  con.connect(function(err) {
    if (err) throw err;
    console.log("Connected!");
    
  });

  con.query("use db1", function (err, result) {
    if (err) throw err;
    console.log("Using db1");
  });

const port = 30000

//let salt = bcrypt.genSaltSync(10);
//var hash = bcrypt.hashSync("Hummer", salt);


app.post('/LOGIN', jsonParser,(req, res) => {
  let user = req.body.username;
  con.query("Select Password from User where Username like \""+user+"\"", function(err, result) {
    if(err) throw err;
    console.log(bcrypt.compareSync(req.body.pwd, result[0].Password));
    res.end("OK");
  })
});

app.post("/CREATE_ACCOUNT/",jsonParser, async (req, res)=>{

    let username = req.body.username;
    let salt = bcrypt.genSaltSync(10);
    let hash_password = bcrypt.hashSync(req.body.pwd, salt);
    let authToken = await generate_AuthToken(25);
    con.query("INSERT INTO User(Username, Password, AuthToken) VALUES(\'"+ username +"\',\'"+ hash_password+"\',\'"+ authToken +"\');", function (err, result) {
      if (err){
        res.end("Failed");
        throw err;
      }
      console.log("inserted user:" + username+", "+ hash_password + ", " + authToken);
    });

    res.end("Success, token:" + authToken);
});

app.post("/UPDATE_GPS/", jsonParser, (req, res)=>{
  let token = req.body.token
  let username = req.body.username

  con.query("Select AuthToken from user where username like\"" +username+"\";", function (err, res) {
    if(err) throw err;
    console.log(res[0].AuthToken);
  });
})



async function generate_AuthToken(length) {
  var result           = '';
  var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  var charactersLength = characters.length;
  for ( var i = 0; i < length; i++ ) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }

  while(!check_token(result)){
    result = generate_AuthToken(length)
  } 
 return result;
}

async function check_token(authToken){
  let test = con.query("Select count(*) as i from User where AuthToken like \"" + authToken +"\";", (err, res)=>{
    if(err) throw err;
    console.log(res);
    if(parseInt(res[0].i) == 0)
      return true
    else
      return false
  })
}

app.listen(port, () => console.log(`Hello world app listening on port ${port}!`))