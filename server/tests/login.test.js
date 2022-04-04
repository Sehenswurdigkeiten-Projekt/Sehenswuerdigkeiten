
let url = "10.10.30.69/LOGIN/"
let res, res2, res3;
test("Trying to login",async ()=>{
    
    res = await fetch(url, {
        method: 'Post',
        body: JSON.stringify(
            {
                "username":"z",
                "pwd":"z"
            } 
        )
    })
    console.log(res);
    expect(res.status).toBe(200)

})