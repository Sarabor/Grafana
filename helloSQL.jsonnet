local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local table = grafana.tablePanel;	#import the tools you want to use				
local sql = grafana.sql;

dashboard.new(
    title = 'HelloSQL_Light!',
    style = 'light',
    description =
        'Ein Dashboard zum Testen von SQLQueries.
         Das Dashboard ist einem Jasperreport nachempfunden.',    
)



.addPanel(					#addPanel adds a row in which you can put panels via the parameters						
    table.new(				#the first paramater is the panel type eg. text, graph, table
        title='SQL_Grafonnet',
    )
    .addTarget(
        sql.target( 
           'SELECT
                datetime AS "time",
                boden_t AS "Temperatur",
                lage_q AS "Lage",
                position_q AS "Position",
                schnitt_q AS "Schnitt"
            FROM h5_boden
            ORDER BY 1',
        )
    ),     
        gridPos={
            x: 0,
            y: 0,
            w: 24,
            h: 24,			#the second parameter is optional. It sets the position and the dimensions of the panel
		} 
)   