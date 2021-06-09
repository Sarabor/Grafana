## Grafonnet 7.0

Grafonnet 7.0 will be the next Grafonnet version. It is slighty different than the current version, and not complete yet. But the components that are present are usable and up-to-date.

You will need Grafonnet 7.0 if you want to use tables and generally I encourage using it as much as you can, because the API Docs are much better and the new syntax looks better too.

Here is an HelloWorld example:

```jsonnet
local grafana = import 'grafonnet-7.0/grafana.libsonnet';   #You will have to import grafonnet-7.0 instead of grafonnet
local dashboard = grafana.dashboard;
local text = grafana.panel.text;	                    #the import of the tools look slighty different, because they are in subfolders

#the rest of the Code looks almost the same
dashboard.new(
    title ='HelloDashboard!',
    editable = false,                                        #the new default for editable is 'true'. Set it to 'false' to ensure the integrity of your dashboards.
)


.addPanel(
    text.new(
        title='HelloWorld',
        content='HelloWorld'
        )
)                                                            #gridpos is no longer a parameter, but instead a function

```

For full documentation visit [Grafonnet 7.0 API DOCS](https://github.com/grafana/grafonnet-lib/blob/master/grafonnet-7.0/DOCS.md).