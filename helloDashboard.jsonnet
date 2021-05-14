local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local text = grafana.text;	#import the tools you want to use				

dashboard.new('HelloPanel!')


.addPanel(					#addPanel adds a row in which you can put panels via the parameters						
    text.new(				#the first paramater is the panel type eg. text, graph, table
        title='HelloWorld',
        content='HelloWorld'
        ),
        gridPos={			#the second parameter is optional. It sets the position and the dimensions of the panel
		} 
)