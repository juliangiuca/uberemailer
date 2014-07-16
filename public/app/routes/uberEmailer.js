uberEmailer.config(['$stateProvider', '$urlRouterProvider', function ($stateProvider, $urlRouterProvider) {

  $stateProvider
    .state('index', {
      url: "/",
      templateUrl: 'templates/emailer/index.html',
      controller: 'EmailerIndexCtrl'
    })

    $urlRouterProvider.otherwise('/');
}])
