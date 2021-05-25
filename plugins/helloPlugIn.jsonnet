local grafana = (import 'grafonnet/grafana.libsonnet');
local plugin = import 'grafonnet-status-panel/plugin.libsonnet';
local vonageStatusPanel = plugin.vonageStatusPanel;
local dashboard = grafana.dashboard;


dashboard.new('HelloPlugin!')


.addPanel(				    #addPanel adds a row in which you can put panels via the parameters
    vonageStatusPanel.new(				    #the first paramater is the panel type eg. text, graph, table
       title='test',
       panelTitle='My panel',
       removePrefix='My',
       maxAlertNumber=5,
       colorMode='Metric',
       colors={
         crit: 'rgba(245, 54, 54, 0.9)',
         disable: '#C4162A',
         ok: 'rgba(50, 128, 45, 0.9)',
         warn: 'rgba(237, 129, 40, 0.9)',
         },
       isGrayOnNoData=true
        ),
        .addTarget(
            { alias: 'alias' },
            vonageStatusPanel.display(
              alias='alias',
              handlerType='Number Threshold',
              decimals=3,
              crit=1,
              warn=0.5,
              showAlways=true
            )
          ),
        gridPos={}			    #the second parameter is optional. It sets the position and the dimensions of the panel
)