const promisePool = require("./db").getPromisePool();

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
    const query2 = "select c.Lon, c.Lat,c.Username from User join User_Friends as b on User.UserID = b.UserID and User.UserID = ? join User as c on FriendID = c.UserID;"
    const [rows, fields] = await promisePool.execute(query2, [userID])
    return rows;
}
exports.getTokenAndPasswordFromUsername = async function (username) {
    let query = "Select Password, AuthToken from User where Username like ?"
    const [rows, fields] = await promisePool.execute(query, [username]);

    return rows;
}
exports.joinUserGroup = async function(groupID, userID){
    let query2 = "Insert into User_UserGroup(?,?)"
    await promisePool.execute(query2, [userID, groupID]);
}
exports.createUserGroup = async function(leaderID, routeID, groupCode){
    const query = "Insert into UserGroup(LeaderID, RouteID, GroupCode) VALUES(?,?,?);"
    await promisePool.execute(query, [leaderID, routeID, groupCode])

}
exports.getGroupidFromLeaderid = async function (leaderID) {
    const query2 = "Select GroupID from UserGroup where LeaderID = ?"
    const [rows, fields] = await promisePool.execute(query2, [leaderID]);
    return rows;
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