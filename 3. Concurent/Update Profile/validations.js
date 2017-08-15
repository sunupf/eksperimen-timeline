var validations = {
  'date' : function(input,req,attribute){
    var dateArray = input.split("-")

    if(dateArray.length != 3){
      return false
    }
    var dateISO = dateArray[2]+"-"+dateArray[1]+"-"+dateArray[0];
    var tanggal = new Date(dateISO)

    if(tanggal == "Invalid Date"){
      return false
    }
    return true;
  },
  'confirmed' : function(value,req,attribute){
    var arrayOfPassword = value.split("#confirm#");
    if(arrayOfPassword.length===2 && arrayOfPassword[0] === arrayOfPassword[1]){
      return true;
    }else{
      return false;
    }
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
