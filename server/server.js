const express = require("express")
const app = express()

var bodyParser = require('body-parser')
var jsonParser = bodyParser.json()
var urlencodedParser = bodyParser.urlencoded({ extended: false })

let port = process.env.PORT

if(port == undefined)
    port = 30000;



//TODO: DELTE USER, DELETE GROUP, DELETE ROUTE, IMPLEMENT !SHIT BELOW!
//TODO: ERROR HANDLING WICHTIG

const request = require("./routes/requests");
const { application } = require("express");

//TODO: should probably return Friends and Groups or maybe make new Post requests
app.get("/", urlencodedParser, jsonParser, (req, res)=>{res.send("hallo")})

app.post("/LOGIN", urlencodedParser,jsonParser,request.login)
app.post("/CREATE_ACCOUNT/", urlencodedParser,jsonParser, request.createAccount)

app.post("/JOIN_GROUP", urlencodedParser,jsonParser, request.joinGroup);
app.post("/DELETE_GROUP", urlencodedParser, jsonParser, request.delteGroup)
app.post("/LEAVE_GROUP", urlencodedParser, jsonParser, request.leaveGroup)
app.post("/GET_GROUPS", urlencodedParser, jsonParser, request.getGroups);

app.post("/CREATE_GROUP", urlencodedParser,jsonParser, request.createGroup)

app.post("/UPDATE_GPS/",urlencodedParser,jsonParser,request.updateGPS)

app.post("/ADD_FRIEND/", urlencodedParser,jsonParser, request.addFriend)
app.post("/REMOVE_FRIEND", urlencodedParser, jsonParser, request.removeFriend);
app.post("/GET_FRIENDREQUESTS", urlencodedParser, jsonParser, request.getFriendRequests);
app.post("/CHANGE_PASSWORD", urlencodedParser, jsonParser, request.changePassword)

app.post("/GET_FRIENDS", urlencodedParser, jsonParser, request.getFriends)
app.post("/UPDATE_IMAGE", urlencodedParser, jsonParser, request.updateImage)
app.post("/GET_GROUPMEMBERS", urlencodedParser, jsonParser, request.getGroupmembers)
app.post("/GET_USERINFO", urlencodedParser, jsonParser, request.getUserInfo)

app.post("/SET_GROUP_ROUTE", urlencodedParser, jsonParser, async function(req, res){

})
app.post("/CREATE_ROUTE", urlencodedParser,jsonParser, async function(req,res){
  
})
app.listen(port, () => console.log(`Hello world app listening on port ${port}!`))
