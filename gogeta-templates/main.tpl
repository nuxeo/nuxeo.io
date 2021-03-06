{{define "main"}}
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Nuxeo.io</title>
        <style>
            * {
             box-sizing: border-box;
            }

            ::-moz-selection {
                background: #46a7de;
                color:#fff;
                text-shadow: none;
            }

            ::selection {
                background: #46a7de;
                color:#fff;
                text-shadow: none;
            }

            html {
                height: 100%;
                font-size: 16px;
                line-height: 1.4;
                color: #333;
                background: #e6f3fa url(/__static__/nuxeo_bg.png) no-repeat right bottom;
                -webkit-text-size-adjust: 100%;
                -ms-text-size-adjust: 100%;
            }

            html,
            input {
                font-family: Arial, sans-serif;
            }

            body {
             text-align: center;
             height: 100%;
             margin: 0;
            }

            header {
              background-color: #fff;
              padding: 1.2em 2em;
              text-align: left;
              position: fixed;
              left: 0;
              right: 0;
            }

            .logo img {
               width: 9em;
            }

            .container {
              margin: 0 auto;
              padding: 0 3em;
              width: 70%;
              display: table;
              height:100%;
              text-align: left;
            }

            .container img {
              width: 100%;
            }

            .column {
             display: table-cell;
             padding: 1em;
             vertical-align: middle;
             height:100%;
            }

            .column.left {
             width:40%
            }
            .column.right {
             width:50%
            }

            h1 {
                font-size: 2.3em;
            }

            p {
                margin: .5em 0;
            }

            input::-moz-focus-inner {
                padding: 0;
                border: 0;
            }

            a {
             text-decoration: none;
             color: #46a7de
            }
        </style>
        <meta http-equiv="refresh" content="5">
    </head>
    <body>
        <header>
         <div class="logo">
          <img alt="Nuxeo Connect" src="/__static__/logo_nuxeo.png">
         </div>
        </header>
        <div class="container">
        	{{template "body" .}}
        </div>
    </body>
</html>
</body>
</html>
{{end}}
