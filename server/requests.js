const promisePool = require("./db").getPromisePool();
const bcrypt = require('bcryptjs');
const dateTime = require('./dateHelper').getDateTime;
const {checkIfUserExists, checkToken, checkGroupCode, getUseridFromUsername, validateToken, checkIfFriends} = require('./dbHelperQueries');
const {generateToken, checkIfValidInput} = require('./requestHelper')

exports.login = async function(req, res)
{
  let user = req.body.username;

  let query = "Select Password, AuthToken from User where Username like ?"
  const [rows, fields] = await promisePool.execute(query, [user]);

  if(rows[0] && bcrypt.compareSync(req.body.pwd, rows[0].Password)){
    console.log("[SERVER %s]: Login succesful sending token:" + rows[0].AuthToken, dateTime());
    res.status(200).send({token : rows[0].AuthToken})
  }
  else{
    console.log("[SERVER %s]: Login Failed for user:" + user, dateTime());
    res.statusMessage = "Wrong Password or Username";
    res.status(401).end();
  }
};

exports.createAccount = async function(req, res)
{

  let username = req.body.username;
  if(await checkIfUserExists(username)){
    console.log("Account creation failed for: " + username);
    res.statusMessage = "User Exists";
    res.status(400).end();
    return;
  }
  
  let salt = bcrypt.genSaltSync(10);
  let hash_password = bcrypt.hashSync(req.body.pwd, salt);
  let authToken = await generateToken(25);

  while(!await checkToken(authToken)){
    authToken = generateToken(length)
  } 

  const query ="INSERT INTO User(Username, Password, AuthToken) VALUES( ?, ?, ?);" 
  const [rows, fields] = await promisePool.execute(query, [username, hash_password, authToken])

  console.log("inserted user:" + username+", "+ hash_password + ", " + authToken);
  res.statusMessage = "Account created"
  res.status(200).send({token : authToken})
}
exports.updateGPS = async function(req, res){

  let token = req.body.token
  let username = req.body.username
  let toNotify = req.body.toNotify //maybe either a GroupID(multiple) or empty for friends

  const query = "update User set Lon = ?, Lat = ? where UserID = ?;"
  const query2 = "select c.Lon, c.Lat,c.Username from User join User_Friends as b on User.UserID = b.UserID and User.UserID = ? join User as c on FriendID = c.UserID;"
  
  if(await validateToken(token, username)){
    let userID = await getUseridFromUsername(username)  
    let lon = parseFloat(req.body.lon)
    let lat = parseFloat(req.body.lat)
    await promisePool.execute(query, [lon, lat, userID])
    const [rows, fields] = await promisePool.execute(query2, [userID])
    console.log("olles passt");
    res.status(200).send(rows);
  }
  else{
    console.log("[SERVER %s]: no valid token for user("+user+")", dateTime());
    res.statusMessage = "Update Failed"
    res.status(402).end()
  }
}

exports.createGroup = async function(req,res)
{
  let leader = req.body.username
  let token = req.body.token
  let routeID = req.body.routeID
  
  if(!await validateToken(token, leader)){
    res.statusMessage = "Failed to create Group"
    res.status(404).end()
    return
  }
  let groupCode = generateToken(6);

  const query = "Insert into UserGroup(LeaderID, RouteID, GroupCode) VALUES(?,?,?);"
  const query2 = "Select GroupID from UserGroup where LeaderID = ?"
  const query3 = "Insert into User_UserGroup Values(?, ?)";

  let leaderID = await getUseridFromUsername(leader);
  while(!await checkGroupCode(groupCode)){
    groupCode = generateToken(6);
  }

  await promisePool.execute(query, [leaderID, routeID, groupCode])
  const rows = await promisePool.execute(query2, [leaderID]);
  await promisePool.execute(query3, [leaderID, rows[0].GroupID]);
  res.status(200).send({"code":groupCode});
}

exports.joinGroup = async function(req,res)
{
  let username = req.body.username;
  let token = req.body.token;
  let groupCode = req.body.code;
  let query = "Select GroupID from UserGroup where GroupCode = ?"
  let query2 = "Insert into User_UserGroup(?,?)"
  let groupID;
  let userID;
  const rows = await promisePool.execute(query, [groupCode])
  if(!await validateToken(token, username) || !rows){
    res.statusMessage = "Failed to join group"
    res.status(405).end();
    return
  }
  groupID = rows[0].GroupID;
  userID = await getUseridFromUsername(username);
  await promisePool.execute(query2, [userID, groupID]);

}

exports.addFriend =  async function(req, res)
{
  let username1 = req.body.username
  let username2 = req.body.friend
  let token = req.body.token

  let isReal = await checkIfUserExists(username2);
  let isValid = await validateToken(token, username1);
  let areFriends = await checkIfFriends(username1 , username2)

  const query = "INSERT INTO User_Friends Values(?,?)"

  if(isValid && isReal && !areFriends){
    let userID1 = await getUseridFromUsername(username1)
    let userID2 = await getUseridFromUsername(username2)
    const [rows, fields] = await promisePool.execute(query,[userID1, userID2])
  }
  else{
    console.log("[SERVER %s]: Failed to add friend(" + username2 + ", "+isReal+") for User("+username1+", "+isValid+")", dateTime())
    res.statusMessage = "Failed to add friend"
    res.status(403).end();
    return;
  }
  console.log("[SERVER %s]: Added friend(%s) for User(%s)", dateTime(), username2, username1);
  res.status(200).end("OK");
}