local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local text = grafana.text;	#import the tools you want to use

dashboard.new('HelloPanel!')


.addPanel(					#addPanel adds a row in which you can put panels via the parameters
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
           gridPos={
                    x: 0,
                    y: 0,
                    w: 24,
                    h: 48,			#the second parameter is optional. It sets the position and the dimensions of the panel
        		}
)