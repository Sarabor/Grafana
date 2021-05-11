local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local text = grafana.text;

dashboard.new('HelloPanel!')

.addPanel(
    text.new(
        title='HelloWorld',
	    content='HelloWorld'
    ),
    gridPos={
        x: 0,
        y: 0,
        w: 12,
        h: 5,
    }
)