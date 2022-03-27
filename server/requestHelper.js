exports.generateToken = function generateToken(length) 
{
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
  
   return result;
}
exports.checkIfValidInput = function checkBody(req, paramName) {
  
  switch (paramName) {
    case "username":
      if(req)
        return true;
      else
        return false;

    case "friend":
      if(req)
        return true;
      else
        return false;

    case "pwd":
      if(req)
        return true;
      else
        return false;

    case "pos":
      return !isNan(req[0]) && !isNan(req[1])   
    
    case "token":
      if(req)
        return true;
      else
        return false;

      
    case "routeID":
      return !isNaN(req)

    case "code":
        return !isNan(req)

    default:
      break;
  }
}
