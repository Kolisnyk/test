(function(){
    angular
    .module('taxi')
    .controller('DialogController', ['$scope', '$http', 'ngDialog', 'apiService', function($scope, $http, ngDialog, apiService) {

        var dispatcher = new WebSocketRails(window.location.host + '/websocket');

        $scope.options = {
            availableOptions: [
            {value: '1'}, {value: '2'}, {value: '3'}, {value: '4'}, 
            {value: '5'}, {value: '6'}, {value: '7'}, {value: '8'}
            ],
            selectedOption: {value: '1'}
        };

        $scope.phone_pattern = /(0)[0-9]{9}/;
        $scope.email_pattern = /^(.+)@(.+)$/;
        $scope.isDispatcher = true;

        function checkStatus(data){
            if (data.driver_id) {
                data.driver_id = data.driver_id.id;
                data.status = 'waiting';
            }
        }

        $scope.addOrder = function(){
            $scope.ngDialogData.passengers = $scope.options.selectedOption.value;
            checkStatus($scope.ngDialogData);
            apiService.newOrder($scope.ngDialogData).then(function(){
                dispatcher.trigger('update_order', { id: $scope.ngDialogData.id });
            });
            return true;
        };

        $scope.updateOrder = function() {
            var url = '/drivers/orders/' + $scope.ngDialogData;
            checkStatus($scope.ngDialogData);
            apiService.updateOrder(url, $scope.ngDialogData).then(function(){
                dispatcher.trigger('update_order', { id: $scope.ngDialogData.id });
            });
            return true;
        };

        $scope.cancelOrder = function() {
            var url = '/drivers/orders/' + $scope.ngDialogData;
            $scope.ngDialogData.status = 'canceled';
            apiService.updateOrder(url, $scope.ngDialogData).then(function(){
                dispatcher.trigger('update_order', { id: $scope.ngDialogData.id });
            }); 
            return true;
        };

    }]);

}) ();
