//
//  HTML.swift
//  IETFNext
//
//  Created by Tom Pusateri on 12/14/22.
//

import Foundation

let BLANK = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Blank</title>
    <style type="text/css" mdedia="screen">
      :root {
          color-scheme: light dark;
      }
    </style>
  </head>
  <body>
    <div></div>
  </body>
</html>
"""

let PLAIN_PRE = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>IETF DNSSD Charter (v01)</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
    <style type="text/css" mdedia="screen">
      :root {
          color-scheme: light dark;
      }
      pre {
         font-family: "Roboto Mono", "courier new", courier, monospace;
         font-size: 16px;
         white-space: pre-wrap;
      }
    </style>
  </head>
  <body>
    <pre>
"""

let PLAIN_POST = """
    </pre>
  </body>
</html>
"""

let IMAGE_PRE = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <style type="text/css" mdedia="screen">
      :root {
          color-scheme: light dark;
      }
      img {
      width: 90%;
      display: block;
      margin-left: auto;
      margin-right: auto;
      margin-top: 40px;
      }
    </style>
  </head>
  <body>
    <div>
        <img src="
"""

let IMAGE_POST = """
">
    </div>
  </body>
</html>
"""
