const promisePool = require("../modules/database/db").getPromisePool();
const bcrypt = require('bcryptjs');
const dateTime = require('../modules/dateHelper').getDateTime;
const db = require("../modules/database/dbHelperQueries");
const {generateToken, checkIfValidInput} = require('./requestHelper')

exports.getFriends = async function(req, res){
  let username = req.body.username
  let token = req.body.token;
  if(await db.validateToken(token, username)){
    let rows = db.getFriends(await db.getUseridFromUsername(username))
    res.status(200).send(rows)
    console.log("[SERVER %s]: Sending Friends to user:" + user, dateTime());
    return;
  }
  console.log("[SERVER %s]: Failed to get Friends for user:" + user, dateTime());
  res.statusMessage = "Failed to get Friends";
  res.status(410).end()
}

exports.login = async function(req, res)
{
  let user = req.body.username;
  let pwd = req.body.pwd;
  rows = await db.getTokenAndPasswordFromUsername(user);

  if(rows[0] && bcrypt.compareSync(pwd, rows[0].Password)){
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
  if(await db.checkIfUserExists(username)){
    console.log("Account creation failed for: " + username);
    res.statusMessage = "User Exists";
    res.status(400).end();
    return;
  }
  
  let salt = bcrypt.genSaltSync(10);
  let hash_password = bcrypt.hashSync(req.body.pwd, salt);
  let authToken = generateToken(25);

  while(!await db.checkToken(authToken)){
    authToken = generateToken(length)
  } 
  await db.insertUser(username, hash_password, authToken);

  console.log("inserted user:" + username+", "+ hash_password + ", " + authToken);
  res.statusMessage = "Account created"
  res.status(200).send({token : authToken})
}

exports.updateGPS = async function(req, res){

  let token = req.body.token
  let username = req.body.username
  let toNotify = req.body.toNotify //maybe either a GroupID(multiple) or empty for friends

  if(await db.validateToken(token, username)){
    console.log("[SERVER %s]: GPS Update for User("+username+")", dateTime())

    let userID = await db.getUseridFromUsername(username)  
    let lon = parseFloat(req.body.lon)
    let lat = parseFloat(req.body.lat)

    await db.updatePOS(lon, lat, userID)
    if(toNotify == "-"){
      rows = await db.getFriendPOS(userID)
      res.status(200).send(rows);
    }
    else{
      let ids = toNotify.split(",")
    }

  }
  else{
    console.log("[SERVER %s]: not a valid token for user("+username+")", dateTime());
    res.statusMessage = "GPS Update Failed"
    res.status(402).end()
  }
}

exports.createGroup = async function(req,res)
{
  let leader = req.body.username
  let token = req.body.token
  let routeID = isNaN(req.body.routeID) ? null : req.body.routeID; 
  
  if(!await db.validateToken(token, leader)){
    res.statusMessage = "Failed to create Group"
    res.status(404).end()
    return
  }
  let groupCode = generateToken(6);

  while(!await db.checkGroupCode(groupCode)){
    groupCode = generateToken(6);
  }
  let leaderID = await db.getUseridFromUsername(leader);
  await db.createUserGroup(leaderID, routeID, groupCode)
  const rows = await db.getGroupidFromGroupcode(groupCode);
  await db.joinUserGroup(leaderID, rows[0].GroupID);

  res.status(200).send({"code":groupCode});
}

exports.changePassword = async function (req, res) {
  let username = req.body.username;
  let token = req.body.token;
  if(await db.validateToken(token, username)){

    let salt = bcrypt.genSaltSync(10);
    let hash_password = bcrypt.hashSync(req.body.pwd, salt);
    await db.changePassword(username, hash_password);

    res.status(200).end("Password changed");
    return;
  }
  res.statusMessage = "Could not change Password"
  res.status(408).end();
}

exports.joinGroup = async function(req,res)
{
  let username = req.body.username;
  let token = req.body.token;
  let groupCode = req.body.code;
  let groupID;
  let userID;

  if(!await db.validateToken(token, username)){
    res.statusMessage = "Failed to join group"
    res.status(405).end();
    return
  }
  
  const rows = await db.getGroupidFromGroupcode(groupCode)
  groupID = rows[0].GroupID;
  userID = await db.getUseridFromUsername(username);

  if(await db.checkIfUserIsInGroup(userID, groupID)){
    res.statusMessage = "Failed to join group"
    res.status(405).end();
    return
  }

  await db.joinUserGroup(userID, groupID);
  res.status(200).end("Joined Group")

}
exports.removeFriend = async function (req, res) {
  let username1 = req.body.username
  let username2 = req.body.friend
  let token = req.body.token


  let isReal = await db.checkIfUserExists(username2);
  let isValid = await db.validateToken(token, username1);

  if(isValid && isReal){
    let uID1 = await db.getUseridFromUsername(username1);
    let uID2 = await db.getUseridFromUsername(username2);
    let areFriends = await db.checkIfFriends(uID1 , uID2)

    if(areFriends){
      await db.removeFriend(uID1, uID2);

      console.log("[SERVER %s]: Friend(%s) and User(%s) are no longer Friends", dateTime(), username2, username1);
      res.status(200).end("Friend removed");
      return;
    }
  }
  console.log("[SERVER %s]: Failed to remove friend(" + username2 + ", "+isReal+") for User("+username1+", "+isValid+")", dateTime())
  res.statusMessage = "Failed to remove Friend"
  res.status(406).end();
  return;

}

exports.addFriend =  async function(req, res)
{
  let username1 = req.body.username
  let username2 = req.body.friend
  let token = req.body.token

  let isReal = await db.checkIfUserExists(username2);
  let isValid = await db.validateToken(token, username1);
  if(isValid && isReal){

    let userID1 = await db.getUseridFromUsername(username1)
    let userID2 = await db.getUseridFromUsername(username2)
    let areFriends = await db.checkIfFriends(userID1 , userID2)
    if(areFriends){
      console.log("[SERVER %s]: Failed to add friend(" + username2 + ", "+isReal+") for User("+username1+", "+isValid+")", dateTime())
      res.statusMessage = "you are already friends"
      res.status(403).end();
      return;
    } 
    let duplicateRequest = await db.checkForFriendrequest(userID1, userID2);
    const rows = await db.checkForFriendrequest(userID2, userID1)

    console.log(duplicateRequest[0].i);

    if(duplicateRequest[0].i == 0){
      if(rows[0].i == 1){
        console.log("[SERVER %s]: Friend(%s) and User(%s) are Friends", dateTime(), username2, username1);

        await db.addFriend(userID1, userID2)
        await db.deleteFriendrequest(userID2, userID1);

        res.status(200).end("You are now Friends");
        return;
      }else{
        await db.addFriendrequest(userID1, userID2);
      }
    }
    else{
      console.log("[SERVER %s]: Failed to add friend(" + username2 + ", "+isReal+") for User("+username1+", "+isValid+")", dateTime())
      res.statusMessage = "you already sent a friendrequest"
      res.status(403).end();
      return;
    }
  }else{
    console.log("[SERVER %s]: Failed to add friend(" + username2 + ", "+isReal+") for User("+username1+", "+isValid+")", dateTime())
    res.statusMessage = "Failed to send Friendrequest"
    res.status(403).end();
    return;
  }
  console.log("[SERVER %s]: Send friendrequest(%s) from User(%s)", dateTime(), username2, username1);
  res.status(200).end("Send");
}

exports.leaveGroup = async function(req, res){
  let username = req.body.username;
  let token = req.body.token;
  let code = req.body.code;

  let valid = await db.validateToken(token, username)
  let groupid = await db.getGroupidFromGroupcode(code);
  if(valid && groupid){
    await db.leaveGroup(await db.getUseridFromUsername(username), groupid);
  }
  else{
    res.statusMessage = "Failed to get Friendrequests"
    res.status(409).end();
  }
}

exports.delteGroup = async function(req, res){

}

exports.getFriendRequests = async function(req, res) {
  let username = req.body.username;
  let token = req.body.token;
  let isValid = await db.validateToken(token, username);

  if(isValid){
    let userID = await db.getUseridFromUsername(username)
    console.log(userID);
    rows = await db.getFriendRequestsForUserID(userID)
    res.status(200).send(rows)
    return
  }
  res.statusMessage = "Failed to get Friendrequests"
  res.status(407).end();
}