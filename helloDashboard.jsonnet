local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local text = grafana.text;

dashboard.new('HelloPanel!')

.addPanel(
	text.new(
		'HelloWorld'
		content = 'HelloWorld'
		)