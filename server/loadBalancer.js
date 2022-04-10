const express = require('express');
const app = express();
const axios = require('axios');
var bodyParser = require('body-parser');
var jsonParser = bodyParser.json()
var urlencodedParser = bodyParser.urlencoded({ extended: false })

var fs = require('fs');
var http = require('http');
var https = require('https');
var privateKey  = fs.readFileSync('key.pem', 'utf8');
var certificate = fs.readFileSync('cert.pem', 'utf8');

const options = {
    key: fs.readFileSync('key.pem'),
    cert: fs.readFileSync('cert.pem')
  };

const httpsAgent = new https.Agent({
	rejectUnauthorized: false, // (NOTE: this will disable client verification)
	cert: fs.readFileSync("cert.pem"),
	key: fs.readFileSync("key.pem"),
	passphrase: "Fallmerayer123!"
})

const servers = [
	"http://10.10.30.21:30000",
	"http://10.10.30.21:30001"
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
		headers: headers/*,
		httpsAgent: httpsAgent*/
	}
	axios.request(config).then(function(sRes){res.send(sRes.data);}).catch(function(err){
		console.log(err);
		res.send(err);
	});
}
app.use(urlencodedParser,jsonParser,(req,res)=>{handler(req, res)});
//const httpsServer = https.createServer(options, app);
//httpsServer.listen(3002, () => console.log("Load Balancer Server listening on PORT 3001!"));
app.listen(3001, err =>{
	err ?
	console.log("Failed to listen on PORT 3001"):
	console.log("Load Balancer Server "
		+ "listening on PORT 3001");
});