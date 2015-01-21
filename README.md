# GenJS - SQL files generator

Sample model to generate SQL files :
```
var entities = {
  "book":{
    "attributes":{
      "id":{"type":"Long","isPK":true},
      "title":{"type":"String"},
      "sells":{"type":"Integer"}
    }
  }
};

module.exports=entities;
```
