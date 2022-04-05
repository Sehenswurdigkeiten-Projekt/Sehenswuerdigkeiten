exports.getPromisePool = function(){
    const bluebird = require('bluebird');
    var mysql = require('mysql2');
    const { resolve } = require("bluebird");

    const pool = mysql.createPool({host:'172.17.0.1', user: 'root', database: 'db1', password: '12345678', Promise: bluebird});
    const promisePool = pool.promise();
    return promisePool
}
