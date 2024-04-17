class RegisterSuccessModel {
  String? message;
  String? email;
  String? emailConfirmationToken;
  RegisterSuccessModel({this.message, this.email, this.emailConfirmationToken});
  factory RegisterSuccessModel.fromJson(Map<String, dynamic> json) {
    return RegisterSuccessModel(
      message: json['message'],
      email: json['email'],
      emailConfirmationToken: json['emailConfirmationToken'],
    );
  }
}
