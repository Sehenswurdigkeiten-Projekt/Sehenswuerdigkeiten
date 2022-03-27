const express = require("express")
const app = express()

var bodyParser = require('body-parser')
var jsonParser = bodyParser.json()
var urlencodedParser = bodyParser.urlencoded({ extended: false })

const port = 30000


//TODO: DELTE USER, DELETE GROUP, DELETE ROUTE, IMPLEMENT !SHIT BELOW!
//TODO: ERROR HANDLING WICHTIG

const request = require("./requests");
const { application } = require("express");

//TODO: should probably return Friends and Groups or maybe make new Post requests

app.post("/LOGIN", urlencodedParser,jsonParser,request.login)
app.post("/CREATE_ACCOUNT/", urlencodedParser,jsonParser, request.createAccount)
app.post("/UPDATE_GPS/",urlencodedParser,jsonParser,request.updateGPS)
app.post("/CREATE_GROUP", urlencodedParser,jsonParser, request.createGroup)
app.post("/JOIN_GROUP", urlencodedParser,jsonParser, request.joinGroup);
app.post("/ADD_FRIEND/", urlencodedParser,jsonParser, request.addFriend)

app.post("/CHANGE_PASSWORD", urlencodedParser, jsonParser, async function(req, res){
  let username = req.body.username 
})
app.post("/CREATE_ROUTE", urlencodedParser,jsonParser, async function(req,res){
  
})
app.post("/SET_GROUP_ROUTE", urlencodedParser, jsonParser, async function(req, res){

})

app.listen(30000, () => console.log(`Hello world app listening on port ${port}!`))
