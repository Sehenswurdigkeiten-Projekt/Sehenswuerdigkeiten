const promisePool = require("./db").getPromisePool();

exports.getFriends = async function getFriends(userID){
    const query = "Select b.Username from User_Friends as a join User as b on b.UserID = a.FriendID and a.UserID = ?;"
    const[rows, fields] = await promisePool.execute(query, [userID])

    return rows;
}      

exports.updateImage = async function updateImage(userID, imageStr){
    const query = "Update User set Image = ? where UserID = ?"
    const[rows, fields] = await promisePool.execute(query, [imageStr, userID]);
    return rows;
}
exports.checkGroupCode = async function check_group_code(code)
{
    const query = "Select count(*) as i from UserGroup where GroupCode = ?"
    const[rows, fields] = await promisePool.execute(query, [code])

    if(rows[0].i == 0)
        return true;
    return false;
  
}
exports.checkToken = async function check_token(authToken)
{
    const query = "Select count(*) as i from User where AuthToken like ?"
    const[rows, fields] = await promisePool.execute(query, [authToken])
    if(rows[0].i == 0)
        return true
    return false;
}

exports.validateToken =  async function validate_token(token, username)
{
    const query = "Select count(*) as i from User where AuthToken like ? and Username like ?"
    const [rows, fields] = await promisePool.execute(query,[token, username]);
    if(rows[0].i == 1)
        return true;
    return false;
}

exports.checkIfUserExists =  async function check_if_user_exists(username)
{
    const query = "Select count(*) as i from User where username like ?"
    const [row, fields] = await promisePool.execute(query,[username])
    if(row[0].i >= 1)
        return true;
    return false;
}

exports.getUseridFromUsername = async function get_userID_from_username(username)
{
    const query = "Select UserID from User where username =?"
    const[row, field] = await promisePool.execute(query, [username])

    if(row[0] && !isNaN(row[0].UserID))
        return row[0].UserID
    return -1
}

exports.checkIfFriends = async function checkIfFriends(userID, friendID) {
    const query = "Select count(*) as i from User_Friends where userID = ? and friendID = ?"
    const[row, field] = await promisePool.execute(query, [userID, friendID])
    
    console.log(row);

    if(row[0].i == 1){
        return true
    }
    else{
        return false
    }
}
exports.insertUser = async function insertUser(username, hash_password, authToken) {
    const query ="INSERT INTO User(Username, Password, AuthToken) VALUES( ?, ?, ?);" 
    const [rows, fields] = await promisePool.execute(query, [username, hash_password, authToken])
    return [rows, fields];
}

exports.insertUser = async function insertUser(username, hash_password, authToken) {
    const query ="INSERT INTO User(Username, Password, AuthToken) VALUES( ?, ?, ?);" 
    const [rows, fields] = await promisePool.execute(query, [username, hash_password, authToken])
    return [rows, fields];
}
exports.updatePOS = async function (lon, lat, userID) {
    const query = "update User set Lon = ?, Lat = ? where UserID = ?;"
    await promisePool.execute(query, [lon, lat, userID]);
    return;   
}
exports.getFriendPOS = async function (userID) {
    const query2 = "select c.Lon, c.Lat,c.Username, c.Image from User join User_Friends as b on User.UserID = b.UserID and User.UserID = ? join User as c on FriendID = c.UserID;"
    const [rows, fields] = await promisePool.execute(query2, [userID])
    return rows;
}
exports.getTokenAndPasswordFromUsername = async function (username) {
    let query = "Select Password, AuthToken from User where Username like ?"
    const [rows, fields] = await promisePool.execute(query, [username]);

    return rows;
}
exports.joinUserGroup = async function(userID, groupID){
    let query2 = "Insert into User_UserGroup Values(?,?)"
    await promisePool.execute(query2, [userID, groupID]);
}
exports.createUserGroup = async function(leaderID, routeID, groupCode){
    const query = "Insert into UserGroup(LeaderID, RouteID, GroupCode) VALUES(?,?,?);"
    await promisePool.execute(query, [leaderID, routeID, groupCode])

}

exports.changePassword = async function(username, pwd){
    let query = "UPDATE User set Password = ? where Username = ?"
    await promisePool.execute(query, [pwd, username]);

}
exports.getGroupidFromGroupcode = async function(groupCode){
    let query = "Select GroupID from UserGroup where GroupCode = ?"
    const [rows, fields] = await promisePool.execute(query, [groupCode])
    return rows;
}
exports.removeFriend = async function(uID1, uID2){
  let query = "Delete from User_Friends where UserID = ? and FriendID = ?"
  await promisePool.execute(query, [uID2, uID1]);
  await promisePool.execute(query, [uID1, uID2]);

}
exports.addFriend = async function(userID1, userID2){
    const query3 = "Insert into User_Friends Values(?, ?)"
    await promisePool.execute(query3, [userID1, userID2])
    await promisePool.execute(query3, [userID2, userID1])

}
exports.deleteFriendrequest = async function(userID1, userID2){
    const query4 = "Delete from User_Friendrequests where UserID = ? and FriendID = ?"
    await promisePool.execute(query4, [userID1, userID2])

}
exports.addFriendrequest = async function(userID1, userID2){
    const query2 = "INSERT INTO User_Friendrequests(UserID, FriendID) Values(?, ?)"
    await promisePool.execute(query2,[userID1, userID2])

}
exports.checkForFriendrequest = async function(userID1, userID2){
    const query = "Select count(*) as i from User_Friendrequests where UserID = ? and FriendID = ?"
    const [rows, fields] = await promisePool.execute(query, [userID1, userID2]);
    return rows;
}
exports.getFriendRequestsForUserID = async function(userID){
  const query = "Select b.Username from User_Friendrequests as a join User as b using(UserID) where a.FriendID = ?;";
  const [rows, fields] = await promisePool.execute(query, [userID]);
  return rows;
}
exports.checkIfUserIsInGroup = async function(userID, groupID){
    const query = "Select count(*) as i from User_UserGroup where UserID = ? and GroupID = ?"
    const [rows, fields] = await promisePool.execute(query, [userID, groupID])
    if(rows[0].i == 1){
        return true;
    }
    return false;
}
exports.leaveGroup = async function(userid, groupid){
    const query = "Delete from User_UserGroup where UserID = ? and GroupID = ?"
    await promisePool.execute(query, [userid, groupid]);

}
exports.getGroupsForUser = async function(userID){
    const query = "Select GroupCode from User_UserGroup as a join UserGroup as b on GroupID = GroupID and UserID = ?"
    const [rows, fields] = await promisePool.execute(query, [userID])
    return rows;
}
exports.getGroupmembers = async function(groupID){
    const query = "Select t.Username, Image,count(Username)-1 as isLeader from (Select Username, Image from User_UserGroup as a join User as b on a.UserID = b.UserID and GroupID = ? Union ALL Select Username, Image from UserGroup as a join User as b on LeaderID = UserID and GroupID = ?) as t group by Username, Image;"
    const[rows, fields] = promisePool.execute(query, [groupID, groupID]);
    return rows;
}

exports.getUserInfo = async function(userID){
    const query = "Select Username, UserID, Image, Authtoken, Lon, Lat from User where UserID = ?"
    const [rows, fields] = await promisePool.execute(query, [userID])
    return rows;
}

const test = "Select count(*) from (Select Username, Image from User_UserGroup as a join User as b on a.UserID = b.UserID and GroupID = 11 Union ALL Select Username, Image from UserGroup as a join User as b on LeaderID = UserID and GroupID = 11) as t"
