exports.getPromisePool = function(){
    const bluebird = require('bluebird');
    var mysql = require('mysql2');
    const { resolve } = require("bluebird");

    const pool = mysql.createPool({host:'localhost', user: 'root', database: 'db1', password: '12345678', Promise: bluebird});
    const promisePool = pool.promise();
    return promisePool
}
