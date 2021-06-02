To use HTML set GF_PANEL_SANITIZE_HTML=true under environment in your docker-compose.yaml.
This will enable the text panel to display HTML.

Once you have done this, you can create a text panel as usual and in content write your html code. There are some things that you have to keep in mind when using the text panel for html with Grafonnet though.

You can not use local files. When you publish your dashboard in Grafana, Grafana will not be able to access your local files. You can however host images or code online, that way Grafana can still access the code. 

There are some symbols that already have a meaning in Jsonnet and have to be escaped to be used. The following symbols must be escaped with \ when using HTML, CSS or JS in Jsonnet: \, '



```jsonnet
text.new(				#the first paramater is the panel type eg. text, graph, table
title='HelloWorld',
mode='html',
content=
'
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<img src="https://cdn1.vogel.de/unsafe/fit-in/1000x0/images.vogel.de/vogelonline/bdb/1792100/1792191/original.jpg" alt="alternatetext">
<h1 style="color:blue;text-align:center;">This is a heading</h1>
<p style="color:red;">This is a paragraph.</p>

        <p id="demo">A Paragraph.</p>

        <button type="button" onclick="myFunction()">Try it</button>

        <p>(myFunction is stored in an external file called "myScript.js")</p>

         <script src="https://www.w3schools.com/js/myScript.js"></script>

         </body>
         </html>
          '
        ),
```