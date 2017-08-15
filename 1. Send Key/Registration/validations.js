var validations = {
  'confirmed' : function(value,req,attribute){
    var arrayOfPassword = value.split("#confirm#");
    if(arrayOfPassword.length===2 && arrayOfPassword[0] === arrayOfPassword[1]){
      return true;
    }else{
      return false;
    }
  },
  'unique' : function(value,req,attribute){
    var unique = require(process.cwd()+'/validations/unique')();
    var param = {
      'negation':false,
      'ruleParam' : "users,email"
    }
    return unique(param,value)
  },
  'joss' : function(value,req,attribute){
    console.log(value.length);
    return value.length > 100
  },
  'min' : function(value,req,attribute){
    if(attribute == "password"){
      var arrayOfPassword = value.split("#confirm#");
      if(arrayOfPassword.length===2 && arrayOfPassword[0].length >= req ){
        return true;
      }else{
        return false;
      }
    }else{
      if(value.length>= req){
        return true
      }
      return false
    }
  }
}

module.exports = validations;
