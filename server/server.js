//maybe move some of this stuff to other files?

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

//TODO: should probably return Friends and Groups or maybe make new Post requests
app.post('/LOGIN', urlencodedParser,jsonParser, async (req, res) => {
  let user = req.body.username;
  let query = "Select Password, AuthToken from User where Username like ?"
  const [rows, fields] = await promisePool.execute(query, [user]);

  if(rows[0] && bcrypt.compareSync(req.body.pwd, rows[0].Password)){
    res.send("OK," + rows[0].AuthToken);
  }
  else{
    console.log("Login Failed for user:" + user);
    res.statusMessage = "Wrong Password or Username";
    res.status(401).end();
  }
});

//TODO: ERROR HANDLING WICHTIG
//TODO: Check for duplicates
app.post("/CREATE_ACCOUNT/",urlencodedParser,jsonParser, async (req, res)=>{

  let username = req.body.username;

  console.log(req.body.username);



  if(await check_if_user_exists(username)){
    res.statusMessage = "User Exists";
    res.status(400).end();
    return;
  }

  let salt = bcrypt.genSaltSync(10);
  let hash_password = bcrypt.hashSync(req.body.pwd, salt);
  let authToken = await generateToken(25);


  while(!await check_token(authToken)){
    authToken = generateToken(length)
  } 

  const query ="INSERT INTO User(Username, Password, AuthToken) VALUES( ?, ?, ?)" 
  const [rows, fields] = await promisePool.execute(query, [username, hash_password, authToken])

  console.log("inserted user:" + username+", "+ hash_password + ", " + authToken);
  res.statusMessage = "Account created"
  res.status(200).send({token : authToken})
});

app.post("/UPDATE_GPS/",urlencodedParser,jsonParser, async (req, res)=>{
  console.log("gps")
  let token = req.body.token
  let username = req.body.username
  let pos = req.body.pos

  console.log(pos);

  let toNotify = req.body.toNotify //maybe either a GroupID(multiple) or empty for friends
  const query = "UPDATE User set CurrentPos = ? where UserID = ?"
  const query2 = "SELECT Username, CurrentPos, FriendID from User join User_Friends on UserID = UserID and User.UserID = ?"
  if(await validate_token(token, username)){
    let userID = get_UserID_from_Username(username)
    await promisePool.execute(query, [pos, userID])
    const [rows, fields] = await promisePool.execute(query2, [userID])
    res.end(rows);
  }
  else
    res.end("Fogg")

})
//TODO: Set up DB again
//TODO: DELTE USER, DELETE GROUP, DELETE ROUTE, IMPLEMENT !SHIT BELOW!

//should probably return GroupID
app.post("/CREATE_GROUP", jsonParser, async function(req,res){
  let leader = req.body.username
  let token = req.body.token
  let routeID = req.body.routeID
  
  if(!await validate_token(token, leader)){
    res.statusMessage = "Failed to create Group"
    res.status(404).end()
    return
  }
  let groupCode = generateToken(6);

  const query = "Insert into UserGroup(LeaderID, RouteID, GroupCode) VALUES(?,?,?);"

  let leaderID = get_UserID_from_Username(leader);
  while(!await check_group_code(groupCode)){
    groupCode = generateToken(6);
  }

  res.send(groupCode);
  
  const [rows, fields] = await promisePool.execute(query, [leaderID, routeID, groupCode])
})

app.post("/JOIN_GROUP", jsonParser, async function(req,res){
  
})

app.post("/CREATE_ROUTE", jsonParser, async function(req,res){
  
})

app.post("/ADD_FRIEND/", jsonParser, async (req, res)=>{
  let username1 = req.body.username
  let username2 = req.body.friend
  let token = req.body.token

  let isReal = await check_if_user_exists(username2);
  let isValid = await validate_token(token, username1);

  const query = "INSERT INTO User_Friends Values(?,?)"


  if(isValid && isReal){
    let userID1 = await get_UserID_from_Username(username1)
    let userID2 = await get_UserID_from_Username(username2)
    console.log(userID1, userID2);
    const [rows, fields] = await promisePool.execute(query,[userID1, userID2])
  }
  else{
    res.statusMessage = "Failed to add friend"
    res.status(403).end();
  }
  res.end("done");

})
  //TODO: maybe move these to new File
  async function get_UserID_from_Username(username){
    const query = "Select UserID from User where username =?"
    const[row, field] = await promisePool.execute(query, [username])
    
    if(row[0] && !isNaN(row[0].UserID))
      return row[0].UserID
    return -1

  }

async function check_if_user_exists(username){
  const query = "Select count(*) as i from User where username like ?"
  const [row, fields] = await promisePool.execute(query,[username])
  if(row[0].i >= 1)
    return true;
  return false;
}

async function validate_token(token, username){
  const query = "Select count(*) as i from User where AuthToken like ? and Username like ?"
  const [rows, fields] = await promisePool.execute(query,[token, username]);
  if(rows[0].i == 1)
    return true;
  return false;
}


//TODO: maybe move this to new file
async function generateToken(length) {
  var result           = '';
  var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  var charactersLength = characters.length;
  for ( var i = 0; i < length; i++ ) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
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

async function check_group_code(code){
  console.log(code);
  const query = "Select count(*) as i from UserGroup where GroupCode = ?"
  const[rows, fields] = await promisePool.execute(query, [code])

  if(rows[0].i == 0)
    return true;
  return false;

}


app.listen(port, () => console.log(`Hello world app listening on port ${port}!`))
