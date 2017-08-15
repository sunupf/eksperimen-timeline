var confirmed = function(param){

  var callback = function(param,value){
    var RandExp = require('randexp');

    if(!param.negation){
        return value+"#confirm#"+value
    }else{
        var cp = new RandExp(/[a-zA-Z0-9!@$%&*_]{1,20}/).gen();
        return value+"#confirm#"+cp
    }
  }

  return callback;
}

module.exports = confirmed;
