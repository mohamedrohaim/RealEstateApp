class ErrorModel {
  String? emailError;
  String? passwordError;

  ErrorModel({this.emailError, this.passwordError});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(emailError: json['emailError'],passwordError: json['passwordError']);
  }
}
