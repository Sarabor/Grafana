local grafana = (import 'grafonnet/grafana.libsonnet');
local plugin = import 'grafonnet-status-panel/plugin.libsonnet';
local vonageStatusPanel = plugin.vonageStatusPanel;
local dashboard = grafana.dashboard;


dashboard.new('HelloPlugin!')


"panels": [
    {
      "datasource": "TestData DB",
      "fieldConfig": {
        "defaults": {},
        "overrides": []
      },
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 0
      },
      "id": 4,
      "options": {
        "SVGBaseFix": true,
        "add100Percentage": true,
        "centerAlignContent": true,
        "codeData": "{\n  \"text\": \"Random text\"\n}",
        "css": "* {\n  font-family: Open Sans;\n}\n\n.box {\n  border: solid #555 2px;\n  border-radius: 10px;\n  padding: 10px 20px;\n}\n",
        "dynamicData": false,
        "html": "<div style=\"text-align: center;\">\n  <div class=\"box\" id=\"htmlgraphics-text\"></div>\n  <br />\n  <div class=\"box\" id=\"htmlgraphics-value\"></div>\n</div>\n",
        "onInit": "// Sets the text from customProperties\nconst htmlgraphicsText = htmlNode.getElementById('htmlgraphics-text');\n\nif (htmlgraphicsText) {\n  htmlgraphicsText.textContent = customProperties.text;\n\n  // Change the text color based on the theme\n  if (theme.isDark) {\n    htmlgraphicsText.style.color = 'green';\n  } else {\n    htmlgraphicsText.style.color = 'red';\n  }\n}\n",
        "onRender": "// Sets the value from the first series on every refresh\nconst htmlgraphicsValue = htmlNode.getElementById('htmlgraphics-value');\n\nif (htmlgraphicsValue) {\n  htmlgraphicsValue.textContent = data.series[0].fields[1].state.calcs.last;\n}\n",
        "overflow": "visible",
        "panelupdateOnMount": true,
        "renderOnMount": true
      },
      "pluginVersion": "7.5.4",
      "title": "Panel Title",
      "type": "gapit-htmlgraphics-panel"
    }
  ],
  "schemaVersion": 27,
  "style": "dark",
  "tags": [],
  "templating": {
    "list": []
  }