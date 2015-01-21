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

to generate these SQL files :
* mysql :
```
-- mysql

-- book
CREATE TABLE book (
    id bigint,
    title varchar(),
    sells integer
);
```
* postgresql :
```
-- postgresql

-- book
CREATE TABLE book (
    id numeric,
    title varchar(),
    sells integer
);
```
