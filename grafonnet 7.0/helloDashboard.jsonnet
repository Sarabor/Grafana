local grafana = import 'grafonnet-7.0/grafana.libsonnet';
local dashboard = grafana.dashboard;
local text = grafana.panel.text;	#import the tools you want to use

dashboard.new(
    title ='HelloPanel!',
    editable = false,
)


.addPanel(
    text.new(
        title='HelloWorld',
        content='HelloWorld'
        )
)
