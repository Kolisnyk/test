(function(){
    angular
    .module('taxi')
    .controller('DispatchersController', ['$scope', '$http', 'ngDialog', 'apiService', function($scope, $http, ngDialog, apiService) {

        var dispatcher = new WebSocketRails(window.location.host + '/websocket');
        var notification = document.getElementById('notification');

        apiService.getDispatcherOrders().then(function(data){
            $scope.orders = data;
        });

        apiService.getDrivers().then(function(data){
            $scope.drivers = data;
        });

        function isExist(arr, data){
            var index = -1;
            arr.forEach(function(el){
                if (el.id === data.id) {
                    index = arr.indexOf(el);
                }
            });
            return index;
        }

        dispatcher.bind('new_driver', function(data) {
            var index = isExist($scope.drivers, data);
            if (index === -1) {
                $scope.drivers.push(data);
                $scope.$apply();
            }
        });

        dispatcher.bind('remove_driver', function(data) {
            var index = isExist($scope.drivers, data);
            if (index !== -1) {
                $scope.drivers.splice(index, 1);
                $scope.$apply();
            }
        });

        dispatcher.bind('new_order', function(data) {
            var index = isExist($scope.orders, data);
            if (index === -1) {
                $scope.orders.push(data);
                $scope.$apply();
                notification.play();
            }
        });

        dispatcher.bind('change_order', function(data) {
            var index = isExist($scope.orders, data);
            if (index !== -1) {
                $scope.orders[index] = data;
                $scope.$apply();
            }
        });

        dispatcher.bind('remove_order', function(data) {
            var index = isExist($scope.orders, data);
            if (index !== -1) {
                $scope.orders.splice(index, 1);
                $scope.$apply();
            }
        });

        dispatcher.bind('ping', function() {
            dispatcher.trigger('pong', { msg: 'pong' });
        });

        $scope.create = function(){
            ngDialog.open({ template: 'templates/order.html', scope: $scope, controller: 'DialogController', className: 'ngdialog-theme-default' });
        };

        $scope.update = function(order){
            order.isUpdating = true;
            ngDialog.open({ template: 'templates/order.html', data: order, scope: $scope, controller: 'DialogController', className: 'ngdialog-theme-default' });
        };

        $scope.confirmCancel = function(order){
            ngDialog.open({ template: 'confirm', data: order, controller: 'DialogController', className: 'ngdialog-theme-default' });
        };

    }]);

}) ();
