local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local text = grafana.text;
local template = grafana.template;
local singlestat = grafana.singlestat;
local graphPanel = grafana.graphPanel;

dashboard.new(
    'AdvancedDashboard',
    schemaVersion=26,
    tags=['advanced'],
    refresh='60s',
)

.addTemplate(
    grafana.template.datasource(
        name='TestData_DS',
        current='TestData DB',
        query='testdata',
        hide='label',
    )
)

.addTemplate(
    grafana.template.interval(
        name='Interval',
        current='5m',
        query='auto, 5m, 10m, 20m',
    )
)

.addPanel(
    singlestat.new(
        title='Data',
        format='avg',
        datasource='TestData DB',
        valueName='Average',
        ),
        gridPos={
            x:0,
            y:0,
            w:12,
            h:5,
        }
)



.addPanel(
    graphPanel.new(
        title='Graph'
    ),
    gridPos={
        x:0,
        y:0,
        w:12,
        h:5,
    }

)