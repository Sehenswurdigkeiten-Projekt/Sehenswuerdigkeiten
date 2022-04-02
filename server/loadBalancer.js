const express = require('express');
const app = express();
const axios = require('axios');
var bodyParser = require('body-parser');
var jsonParser = bodyParser.json()
var urlencodedParser = bodyParser.urlencoded({ extended: false })


const servers = [
	"http://10.10.30.69:30000",
	"http://10.10.30.69:30000"
]

let current = 0;

const handler = async (req, res) =>{
	const { method, url, headers, body } = req;
	const server = servers[current];
	current === (servers.length-1)? current = 0 : current++
	delete headers["accept"]
	delete headers["content-length"]

	config =  {
		url : url,
		method : method,
		baseURL : server,
		data : body,
		headers: headers
	}
	axios.request(config).then(function(sRes){console.log(res.send(sRes.data));});
}
app.use(urlencodedParser,jsonParser,(req,res)=>{handler(req, res)});

app.listen(3001, err =>{
	err ?
	console.log("Failed to listen on PORT 3001"):
	console.log("Load Balancer Server "
		+ "listening on PORT 3001");
});
