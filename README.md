Simple Table Service
====================

Simple REST service for serving statistical output tables. The service is
used by [StatMiner](https://github.com/statmine/statminer). 

Install node packages

```
npm install
```

Start server

```
nodejs server.js
```


Interface
---------

- A GET on [http://localhost:8088/tables](http://localhost:8088/tables) returns
  a list of tables. 
- A GET on [http://localhost:8088/<tablename>/schema](http://localhost:8088/<tablename>/schema) 
  returns the schema of the table in 
  [http://data.okfn.org/doc/tabular-data-package](http://data.okfn.org/doc/tabular-data-package)
  format. 
- A GET on [http://localhost:8088/<tablename>/data](http://localhost:8088/<tablename>/data) 
  returns the data in CSV format.
- A POST on [http://localhost:8088/<tablename>/query](http://localhost:8088/<tablename>/query) 
  returns a subset (as specified by the query) with schema.

