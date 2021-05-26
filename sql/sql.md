## SQL

In this readme I will show you a sample programm to use sql queries.

```jsonnet
local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local table = grafana.tablePanel;	#import the tools you want to use				
local sql = grafana.sql;

dashboard.new(
    title = 'Hochofen',
    style = 'light',
)



.addPanel(				#addPanel adds a row in which you can put panels via the parameters						
    table.new(				#the first paramater is the panel type eg. text, graph, table
        title='Bodentemperatur',
    )
    .addTarget(                         #add a target for the table
        sql.target(                     #declare the target to be a sql query, insert sql query between ' '
           'SELECT                     
                column
            FROM data,
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
test