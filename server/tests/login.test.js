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

    res = await axios.request(config)
    expect(res.status).toBe(200)
})

test("Trying to login2",async ()=>{
    let body = {username:"Larcher1234", "pwd":"Hummer"}

    config =  {
        method : method,
        baseURL : server,
        data : body
    }

    await axios.request(config).catch((error)=>{
        expect(error.response.status).toBe(401)
    })
})