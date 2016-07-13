
/**
 * Created by SAROJINI on 7/12/2016.
 */
/**
 * Created by SAROJINI on 7/12/2016.
 */

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