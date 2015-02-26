

var memberPage = angular.module('memberPage', ['ngRoute']);

memberPage.config(function ($routeProvider){

		$routeProvider

			.when('/', {
				templateUrl: '../pages/dashboard.html',
				controller: 'dashBoardController'
			})

			.when('/PD', {
				templateUrl: '../pages/PD.html',
				controller: 'PDController'
			})

});

memberPage.service('iniData', function() {

	this.id = user.id
	this.handle = user.handle;
	this.balance = account.balance;

});


memberPage.controller('navBarController', ['$scope', '$log', 'iniData', function($scope, $log, iniData){

	$scope.handle = iniData.handle


}]);


memberPage.controller('dashBoardController', ['$scope', '$log', 'iniData', function($scope, $log, iniData){


}]);


memberPage.controller('PDController', ['$scope', '$log', 'iniData', '$http', function($scope, $log, iniData, $http){

	$scope.balance = iniData.balance

	$http.get('/api/manipulations/'+iniData.id)
		.success(function (result){
			$scope.manipulations = result
		})
		.error(function (){
			console.log("I have an error while fetching users manipulations and this is the data I got:")
			console.log(arguments)
		});

}]);

memberPage.directive('manipulation', function(){

	return {
		restrict: 'AE',
		templateUrl: '../directives/manipulation.html',
		replace: true,
	}

})