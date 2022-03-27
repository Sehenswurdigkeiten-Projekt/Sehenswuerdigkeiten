const promisePool = require("./db").getPromisePool();

exports.checkGroupCode = async function check_group_code(code)
{
    console.log(code);
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


    if(row[0].i == 1){
        return true
    }
    else{
        return false
    }
}