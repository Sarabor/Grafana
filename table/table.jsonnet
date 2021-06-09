local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local table = grafana.tablePanel;	#import the tools you want to use

dashboard.new(
    title = 'SQL_Dashboard',
)



.addPanel(				#addPanel adds a row in which you can put panels via the parameters
    table.new(
    'with batch transformations',
    span=12,
    styles=null
    ),
        gridPos={
            x: 0,
            y: 0,
            w: 24,
            h: 48,			#the second parameter is optional. It sets the position and the dimensions of the panel
		}
)

