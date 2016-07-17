<%--
  Created by IntelliJ IDEA.
  User: SAROJINI
  Date: 7/8/2016
  Time: 2:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html data-ng-app = "gestire">
  <head>
    <meta charset="utf-8" />
    <script type = "text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/foundation/5.4.0/css/normalize.css"/>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/foundation/5.4.0/css/foundation.css"/>
    <script type = "text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.7/angular.min.js"></script>
    <script type = "text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.7/angular-route.js"></script>
      <%--<script type = "text/javascript" src="index.jsp"></script>--%>
      <%--<script type="text/javascript" src="controllers.js"></script>--%>
    <title>$Title$</title>
      <base href="/">
  </head>
  <body>
    <data-ng-view></data-ng-view>
  <script type="text/javascript">
    console.log("hey entered here");
    var gestire = angular.module('gestire',['ngRoute']);
      gestire.config(function($routeProvider,$locationProvider){
          $locationProvider.html5Mode(true);
          //console.log($locationProvider('login.html',src));
          $routeProvider
                  .when('/',
                          {
                              controller:'loginController',
                              templateUrl: 'src/views/login.html'
                          })
                  .when('/signup',
                          {
                              controller:'signupController',
                              templateUrl: 'views/signup.html'
                          })
                  .otherwise({redirectTo:'/'});
      });
    gestire.controller('loginController',function($scope,$http){
          $scope.handleLogin = function() {
              var data = {
                  username: $scope.username,
                  password: $scope.password
              };
              console.log(data);

              var config = {
                  headers : {
                      'Content-Type': 'application/x-www-form-urlencoded'
                  }
              };
              $http.post('/servlet/login', data, config)
                      .then(function successCallback(response) {
                          $scope.displayString = response.data;
                          console.log(response);
                      }, function errorCallback(response) {
                          console.log(response);
                      });
          };
      });
    gestire.controller('signupController',function($scope,$http){
        $scope.handleSignUp = function(){
            var data = {
                username: $scope.username,
                password: $scope.password,
                name: $scope.name
            }
            var config = {
                headers : {
                    'Content-Type': 'application/x-www-form-urlencoded'
                }
            };
            $http.post('/servlet/signup', data, config)
                    .then(function successCallback(response) {
                        $scope.displayString = response.data;
                        console.log(response);
                    }, function errorCallback(response) {
                        console.log(response);
                    });
        };

    });
      gestire.controller('searchController',function($scope,$http){
          $scope.handleSearch = function(){
              var data;
              $scope.categories = [
                  {
                      name: "Dresses"
                  },
                  {
                      name: "Appliances"
                  },
                  {
                      name: "Electronics"
                  }
               ] ;
              $scope.selectDresses = function() {
                  $scope.Dress = $scope.categories[ 0 ];
                  data = {
                        item: $scope.Dress
                  }
              };
              $scope.selectAppliances = function() {
                  $scope.Appliance = $scope.categories[ 1];
                  data = {
                      item: $scope.Appliance
                  }
              };
              $scope.selectElectronics = function() {
                  $scope.Electronic = $scope.categories[ 2 ];
                  data = {
                      item: $scope.Electronic
                  }
              };
              var config = {
                  headers : {
                      'Content-Type': 'application/x-www-form-urlencoded'
                  }
              };
              $http.post('/servlet/search', data, config)
                      .then(function successCallback(response) {
                          var arr = request.getAttribute("list");
                          $scope.displayString = response.data;
                          console.log(response);
                      }, function errorCallback(response) {
                          console.log(response);
                      });
          };


          };
      });

  </script>
  </body>
</html>
