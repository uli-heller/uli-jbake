<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <title><%if (content.title) {%>${content.title}<% } else { %>JBake<% }%></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="keywords" content="">
    <meta name="generator" content="JBake">

    <!-- Le styles -->
    <link href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>css/bootstrap.min.css" rel="stylesheet">
    <link href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>css/asciidoctor.css" rel="stylesheet">
    <link href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>css/base.css" rel="stylesheet">
    <link href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>css/prettify.css" rel="stylesheet">
    <link href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>css/uli.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>js/html5shiv.min.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <!--<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">-->
    <link rel="shortcut icon" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>dpicon.png">
    <link rel="icon" type="image/png" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>dpicon.png">

    <!-- highlight.js -->
    <link rel="stylesheet" href="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>js/highlight.js/8.6/styles/default.min.css">
    <script src="<%if (content.rootpath) {%>${content.rootpath}<% } else { %><% }%>js/highlight.js/8.6/highlight.min.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
 
  </head>
  <body onload="prettyPrint()">
    <header role="banner">
      <div class="container-fluid">
        <hgroup>
          <h1><a href="/">Was ich so treibe...</a></h1>
          <h2>Uli's IT-Blog - Konzeption, Entwicklung, Betrieb</h2>
        </hgroup>
      </div>
    </header>
    <div id="wrap">
   
