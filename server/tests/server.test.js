const { default: axios } = require("axios");
let server = "http://10.10.30.21:3001/"
let method = "GET"

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