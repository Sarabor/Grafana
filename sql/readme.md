## SQL

In this readme I will show you a sample programm to use sql queries.

```jsonnet
local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local table = grafana.tablePanel;	#import the tools you want to use				
local sql = grafana.sql;

dashboard.new(
    title = 'SQL_Dashboard',
    style = 'light',
)



.addPanel(				#addPanel adds a row in which you can put panels via the parameters						
    table.new(				#the first paramater is the panel type eg. text, graph, table
        title='Tabelle',
    )
    .addTarget(                         #add a target for the table
        sql.target(                     #declare the target to be a sql query, insert sql query between ' '
           'SELECT                     
                column AS "time",	#Grafana searches for a column named "time" and gives an error when it's not found
		column 			#you need at least two columns for Grafana to show you the data
            FROM data',
        )
    ),     
        gridPos={
            x: 0,
            y: 0,
            w: 24,
            h: 48,			#the second parameter is optional. It sets the position and the dimensions of the panel
		} 
)   
```
