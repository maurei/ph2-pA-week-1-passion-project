var memberPage = angular.module('memberPage', ['ui.router']);

console.log('im alive')

memberPage.config(['$stateProvider', '$urlRouterProvider', function($stateProvider,   $urlRouterProvider){

		$urlRouterProvider.otherwise('/'),

		$stateProvider
			.state('userpage', {
					url: '',
					templateUrl: '../ng/templates/dashboard.html',
					controller: 'dashBoardController'
			})
			.state('')
}]);





memberPage.controller('dashBoardController', ['$scope', '$log', function($scope, $log){

console.log('dashboard is launched!')

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