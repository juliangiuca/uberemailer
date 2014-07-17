uberEmailer.controller("EmailerIndexCtrl", ["$scope", "$http",
          function EmailerIndexCtrl ($scope, $http) {

  $scope.emailTo = undefined;
  $scope.emailFrom = undefined;
  $scope.emailSubject = undefined;
  $scope.emailBody = undefined;
  $scope.sending = false

  $scope.sendEmail = function () {
    $scope.sending = true

    var email = {
      to:       $scope.emailTo,
      from:     $scope.emailFrom,
      subject:  $scope.emailSubject,
      body:     $scope.emailBody
    }

    $http.post("/api/v1/send", email)
    .then(function (response) {
      $scope.sending = false
    })
  }
}])
