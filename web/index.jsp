<%--
  Created by IntelliJ IDEA.
  User: SAROJINI
  Date: 7/8/2016
  Time: 2:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta charset="utf-8" />
    <script type = "text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/foundation/5.4.0/css/normalize.css"/>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/foundation/5.4.0/css/foundation.css"/>
    <script type = "text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.7/angular.min.js"></script>
    <script type = "text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.7/angular-route.js"></script>
    <title>$Title$</title>
  </head>
  <body>

  <div ng-app = "gestire"  >
      <div ng-view = ""> </div>
  </div>

  <script type="text/javascript">
    console.log("hey entered here");
    var gestire = angular.module('gestire',[]);
      gestire.config(function($routeProvider){
          $routeProvider
                  .when('/',
                          {
                               controller:'loginController',
                               templateUrl: 'views/login.html'
                          })
                  .when('/signup',
                          {
                              controller:'signupController',
                              templateUrl: 'views/signup.html'

                          })
                  .otherwise({redirectTo:'/'});
      });

  </script>
  </body>
</html>
