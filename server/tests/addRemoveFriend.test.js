const { default: axios } = require("axios");

let server = "http://10.10.30.21:30000/ADD_FRIEND"
let method = "post"

test("sending Friendrequest",async ()=>{
    let body = {username:"Larcher", token:"X8wNFTXdGQBY0wKpfmwua7zEb",friend:"Larcher2"}

    config =  {
        method : method,
        baseURL : server,
        data : body
    }

    res = await axios.request(config).catch(function(err) {
        console.log(err);
    });
    expect(res.status).toBe(200)
})
test("Accepting Friendrequest",async ()=>{
    let body = {username:"Larcher2", token:"1PFJkhXLJ4oWuXGYk3oPq9rLq",friend:"Larcher"}

    config =  {
        method : method,
        baseURL : server,
        data : body
    }

    res = await axios.request(config)
    expect(res.status).toBe(200)
    
    server = "http://10.10.30.21:30000/REMOVE_FRIEND"
    body = {username:"Larcher", token:"X8wNFTXdGQBY0wKpfmwua7zEb",friend:"Larcher2"}

    config =  {
        method : method,
        baseURL : server,
        data : body
    }

    res = await axios.request(config)
    expect(res.status).toBe(200)
})
