(function() {
    angular
    .module('taxi')
    .controller('DriversController', ['$scope', '$http', 'apiService', function($scope, $http, apiService) {

        var dispatcher = new WebSocketRails(window.location.host + '/websocket');
        var notification = document.getElementById('notification');


        apiService.getDriverOrders().then(function(data){
            $scope.orders = data;
        });

        dispatcher.bind('receive_order', function(data) {
            if (data.status === 'waiting') {
                $scope.orders = [data];
                $scope.$apply();
                notification.play();
            }
        });

        dispatcher.bind('order_timed_out', function(data) {
            $scope.orders = data;
            $scope.$apply();
        });

        dispatcher.bind('ping', function() {
            dispatcher.trigger('pong', { msg: 'pong' });
        });

        $scope.updateStatus = function(order) {
            var url = '/drivers/orders/' + order.id;
            apiService.updateOrder(url, order).then(function(){
                apiService.getDriverOrders().then(function(data){
                    $scope.orders = data;
                });
            });
        };

        $scope.acceptOrder = function(order) {
            order.status = 'accepted';
            $scope.updateStatus(order);
        };

        $scope.declineOrder = function(order) {
            order.status = 'declined';
            $scope.updateStatus(order);
        };

        $scope.arrivedToOrder = function(order) {
            order.status = 'arrived';
            $scope.updateStatus(order);
        };

        $scope.orderFulfilled = function(order) {
            order.status = 'done';
            $scope.updateStatus(order);
        };
    }]);
}) ();
