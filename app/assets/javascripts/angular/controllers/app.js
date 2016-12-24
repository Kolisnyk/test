(function() {
    angular
    .module('taxi', ['ngRoute', 'ngDialog'])
    
    .directive('orderForm', function(){
        return {
            restrict: 'E',
            templateUrl: 'templates/order.html'
        };
    })

    .config(['$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
        $locationProvider.html5Mode(true);
        $routeProvider
            .when('/', {
                templateUrl: 'templates/home.html',
                controller: 'CreateOrderController'
            })
            .when('/drivers/orders', {
                templateUrl: 'templates/driver.html',
                controller: 'DriversController'
            })
            .when('/dispatchers/profile', {
                templateUrl: 'templates/dispatcher.html',
                controller: 'DispatchersController'
            })
            .otherwise({
                redirectTo: '/'
            });
    }])

    .factory('apiService', ['$q', '$http',function($q, $http){
        return {
            updateOrder: function(url, data){
                var deferred = $q.defer();
                $http.put(url, {order: data}).then(function(resp){
                    deferred.resolve(resp.data);
                });
                return deferred.promise;
            },
            newOrder: function(data){
                var deferred = $q.defer();
                $http.post('/orders', {order: data}).then(function(resp) {
                    deferred.resolve(resp.data);
                });
                return deferred.promise;
            },
            getDriverOrders: function(){
                var deferred = $q.defer();
                $http.get('/drivers/orders.json').then(function(resp) {
                    deferred.resolve(resp.data);
                });
                return deferred.promise;
            },
            getDispatcherOrders: function(){
                var deferred = $q.defer();
                $http.get('/dispatchers/orders.json').then(function(resp) {
                    deferred.resolve(resp.data);
                });
                return deferred.promise;
            },
            getDrivers: function(){
                var deferred = $q.defer();
                $http.get('/dispatchers/drivers.json').then(function(resp) {
                    deferred.resolve(resp.data);
                });
                return deferred.promise;
            }
        };
    }]);

}) ();
