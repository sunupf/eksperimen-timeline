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
  'is_numeric' : function(input,req,attribute){
    if(input == ""){
      return true
    }else{
      categories = input.split(",") 
      for(i in categories){
        id = parseInt(categories);
        if(isNaN(id)){
          return false
        }else{
          return true
        }
      }
    }
  },
  'timeline' : function(input,req,attribute){
    return true
  },
  'required' : function(input,req,attribute){
    if(attribute == "content"){
      console.log(input == "")
      console.log(attribute)
      console.log("---------")
      if(input == ""){  
        return false
      }
    }
    return true
  },
  'categories_collection': function(input,req,attribute){
    return true
  }
}

module.exports = validations;
