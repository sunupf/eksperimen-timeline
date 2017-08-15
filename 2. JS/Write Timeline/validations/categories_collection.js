var categories_collection = function(param){

  var callback = function(param,value){

    // require pg
    var dotenv = require('dotenv').config({'path':'../.env'});
    var Client = require('pg-native');
    var _ = require('lodash');

    var id = ""

    var client = new Client();
    client.connectSync();
     
    //text queries 
    //query masih fail

    var categoriesCount = Math.floor(Math.random() * (4) + 1);

    var collection = new Array();

    var indexNotNumeric = _.findIndex(param.validations, function(validation) { return validation == "^is_numeric"; });
    var indexNotRequired = _.findIndex(param.validations, function(validation) { return validation == "^required"; });

    if(indexNotNumeric > -1){
      var RandExp = require('randexp');
      for(i=1;i<=categoriesCount;i++){
        var randomCat = new RandExp(/[a-zA-Z]{1,5}/).gen();
        collection.push(randomCat)
      }
    }else{
      for(i=1;i<=categoriesCount;i++){
        var randomCat = Math.floor(Math.random() * (10))+1;
        collection.push(randomCat)
      }
    }

    if(indexNotRequired > -1){
      collection = []
    }

    console.log(collection)

    return collection.join(",")

  }

  return callback;
}

module.exports = categories_collection;
