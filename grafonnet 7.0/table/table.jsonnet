local grafana = import 'grafonnet-7.0/grafana.libsonnet';
local dashboard = grafana.dashboard;
local table = grafana.panel.table;	#import the tools you want to use

dashboard.new(
    title ='HelloDashboard!',
    editable = false,
)


.addPanel(
    table.new(
        datasource = 'TestData DB',
        description = 'A sample table',
        title = 'HelloTable',
    )
    .setGridPos(
        h = 40,
        w = 20,
        x = 0,
        y = 0,
    )
    .setFieldConfig(
        unit = "Celsius",
        width = 'auto',
    )

)
