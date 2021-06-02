To use HTML set GF_PANEL_SANITIZE_HTML=true under environment in your docker-compose.yaml.
This will enable the text panel to display HTML.

Once you have done this, you can create a text panel as usual and in content write your html code. There are some things that you have to keep in mind when using the text panel for html with Grafonnet though.

You can not use local files. When you publish your dashboard in Grafana, Grafana will not be able to access your local files. You can however host images or code online, that way Grafana can still access the code. 

There are some symbols that already have a meaning in Jsonnet and have to be escaped to be used. The following symbols must be escaped with \ when using HTML, CSS or JS in Jsonnet: \, '

