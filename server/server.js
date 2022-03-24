const express = require("express")
const app = express()

var bodyParser = require('body-parser')
const bluebird = require('bluebird');

var bcrypt = require('bcryptjs');
var jsonParser = bodyParser.json()
var urlencodedParser = bodyParser.urlencoded({ extended: false })

var mysql = require('mysql2');
const { resolve } = require("bluebird");

const pool = mysql.createPool({host:'localhost', user: 'root', database: 'db1', password: '12345678', Promise: bluebird});
const promisePool = pool.promise();

const port = 30000

//let salt = bcrypt.genSaltSync(10);
//var hash = bcrypt.hashSync("Hummer", salt);


app.post('/LOGIN', jsonParser, async (req, res) => {
  let user = req.body.username;
  let query = "Select Password, AuthToken from User where Username like ?"
  const [rows, fields] = await promisePool.execute(query, [user]);

  if(rows[0] && bcrypt.compareSync(req.body.pwd, rows[0].Password)){
    res.send("OK," + rows[0].AuthToken);
  }
  else{
    console.log("Login Failed for user:" + user);
    res.send("Wrong Password or Username");
  }
});

//TODO: ERROR HANDLING WICHTIG
//TODO: Check for duplicates
//TODO: Prevent sql injections
app.post("/CREATE_ACCOUNT/",jsonParser, async (req, res)=>{

    let username = req.body.username;
    let salt = bcrypt.genSaltSync(10);
    let hash_password = bcrypt.hashSync(req.body.pwd, salt);
    let authToken = await generate_AuthToken(25);

    const query ="INSERT INTO User(Username, Password, AuthToken) VALUES( ?, ?, ?)" 
    const [rows, fields] = await promisePool.execute(query, [username, hash_password, authToken])

    console.log("inserted user:" + username+", "+ hash_password + ", " + authToken);
    res.end("Success, token:" + authToken);
});

app.post("/UPDATE_GPS/", jsonParser, async (req, res)=>{
  let token = req.body.token
  let username = req.body.username
  if(await validate_token(token))
    res.end("passt");
  else
    res.end("Fogg");

})

app.post("/ADD_FRIEND/", jsonParser, async (req, res)=>{
  let username1 = req.body.username
  let username2 = req.body.friend
  let token = req.body.token
  
  let userID1 = await get_UserID_from_Username(username1)
  let userID2 = await get_UserID_from_Username(username1)
  
  let isReal = await check_if_user_exists(username1) && await check_if_user_exists(username2);
  let isValid = await validate_token(token);

  const query = "INSERT INTO User_Friends Values(?,?)"
  if(isValid && isReal){
    console.log(userID1, userID2);
    const [rows, fields] = await promisePool.execute(query,[userID1, userID2])
  }
  res.end("done");

})

  async function get_UserID_from_Username(username){
    const query = "Select UserID from User where username =?"
    const[row, field] = await promisePool.execute(query, [username])
    if(!isNaN(row[0].UserID))
      return row[0].UserID
    return resolve(-1)

  }

async function check_if_user_exists(username){
  const query = "Select count(*) as i from User where username like ?"
  const [row, fields] = await promisePool.execute(query,[username])
  if(row[0].i == 1)
    return true;
  return false;
}

async function validate_token(token){
  const query = "Select count(*) as i from User where AuthToken like ?"
  const [rows, fields] = await promisePool.execute(query,[token]);
  if(rows[0].i == 1)
    return true;
  return false;
}

async function generate_AuthToken(length) {
  var result           = '';
  var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  var charactersLength = characters.length;
  for ( var i = 0; i < length; i++ ) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }

  while(!await check_token(result)){
    result = generate_AuthToken(length)
  } 
 return result;
}

async function check_token(authToken){
  const query = "Select count(*) as i from User where AuthToken like ?"
  const[rows, fields] = await promisePool.execute(query, [authToken])
  if(rows[0].i == 0)
    return true
  return false;
}

app.listen(port, () => console.log(`Hello world app listening on port ${port}!`))