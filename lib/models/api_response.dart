library wallet_whitelabel;

class ApiResponse {
  String? errorMessage;
  var response;
  bool? authError = false;

  bool? get isValid => errorMessage == null;

  ApiResponse({this.errorMessage, this.response, this.authError = false}) {
    if (authError!) {
      errorMessage = '';
      response = null;
      // NavigationUtils().logoutUser();
    }
  }

  @override
  String toString() {
    return 'ApiResponse{errorMessage: $errorMessage, response: $response}';
  }
}
