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
      <link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
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
                              templateUrl: 'views/login.html'
                          })
                  .when('/signup',
                          {
                              controller:'signupController',
                              templateUrl: 'views/signup.html'
                          })
                  .when('/search',
                          {
                              controller: 'searchController',
                              templateUrl : 'views/search.html'
                          })
                  .when('/choose',
                          {
                            controller: 'chooseController',
                              templateUrl: 'views/choose.html'
                          })
                  .when('/cart',
                          {
                            controller: 'cartController',
                              templateUrl: 'views/cart.html'
                          })
                  .otherwise({redirectTo:'/'});
      });
    gestire.controller('loginController',function($scope,$rootScope,$http,$location){
        $scope.username = "sarojini";
        $scope.password = "grey";
          $scope.handleLogin = function() {
              var data = {
                  username: $scope.username,
                  password: $scope.password
              };
              $rootScope.username1 = $scope.username;
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
                          $location.path('/search');
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
            };
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

    gestire.factory('cartFactory', function($location){
        var fact = {};
        var cart = [];
        var quantity = 0;
        fact.DisplayCart = function(){
            $location.path('/cart');
        };
        fact.pushToCart = function(product){
            var found = false;
            angular.forEach(cart, function(item) {
                if ( item.name == product.name) { // Found it
                    found = true;
                    item.quantity += 1; // Add one
                    item.price = product.price;
                }
            });
            if (!found) {
                cart.push(angular.extend({quantity: 1}, product));
            }

        };
        fact.getCart = function(){
            return cart;
        };
        return fact;
    });
      gestire.controller('searchController',function($scope,$rootScope,$http,$location,cartFactory) {
          $scope.name = $rootScope.username1;
          $scope.handleSearch = function (item) {
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
              ];
              $scope.sendCategory(item);
          };

          $scope.sendCategory = function(item){
              var data = {
                  item: item
              };
              console.log(data);
              var config = {
                  headers: {
                      'Content-Type': 'application/x-www-form-urlencoded'
                  }
              };
              $http.post('/servlet/search', data, config)
                      .then(function successCallback(response) {
                          console.log(response.data);
                          $rootScope.items = response.data;
                      }, function errorCallback(response) {
                          console.log(response);
                      });
          };
          $scope.click = function(){
              $location.path('/choose');
          };
          $scope.DisplayCart = function(){
              cartFactory.DisplayCart();
          };
      });

      gestire.controller('chooseController',function($scope,$rootScope,$location,$http,cartFactory) {
          $scope.items1 = $rootScope.items;
          $scope.AddtoCart = function(product){
              cartFactory.pushToCart(product);
          };
          $scope.DisplayCart = function() {
              cartFactory.DisplayCart();
          };
      });

      gestire.controller('cartController',function($scope,$location,$http,cartFactory){
          console.log($scope.cartContents);
            $scope.cartContents = cartFactory.getCart();
          console.log($scope.cartContents);
          $scope.$on('$routeChangeStart', function ($scope, next, current) {
              if (next.$$route.controller == "loginController") {
                  $location.path('/');
              }
              if (next.$$route.controller == "searchController") {
                  $location.path('/search');
              }
          });
          $scope.getCartPrice = function(){
                var total = 0;
              $scope.cartContents.forEach(function (product) {
                  total += parseFloat(product.price.replace('$',' ')) * product.quantity;
                  console.log("parseInt:" + parseFloat(product.price.replace('$',' ')));
                  console.log("each stage: " + product.quantity);
              });
              console.log("total price: " + total);
              return total;
          };
      });
  </script>
  </body>
</html>
