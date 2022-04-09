const { default: axios } = require("axios");

let server = "http://10.10.30.21:30000/LOGIN"
let method = "post"

let res, res2, res3;
test("Trying to login",async ()=>{
    let body = {username:"Larcher", "pwd":"Hummer"}

    config =  {
        method : method,
        baseURL : server,
        data : body
    }

    for (let index = 0; index < 100; index++) {
        res = await axios.request(config)
        expect(res.status).toBe(200)        
    }
})