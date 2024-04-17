class LoginModel {
  String? userId;
  String? name;
  String? userName;
  String? email;
  String? token;
  String? expirationTokenDate;
  List<String>? roles;

  LoginModel(
      {this.userId,
      this.name,
      this.userName,
      this.email,
      this.token,
      this.expirationTokenDate,
      this.roles});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json["emil"],
      expirationTokenDate: json['expirationTokenDate'],
      name: json['name'],
      roles: json["roles"].cast<String>(),
      token: json['token'],
      userId: json['userId'],
      userName: json['userName'],
    );
  }
}
