// {
//     "message": "Email Not Found",
//     "errors": null
// }
class ErrorMassegeModel {
  String? message;
  String? errors;
  ErrorMassegeModel({this.message, this.errors});
  factory ErrorMassegeModel.fromJson(Map<String, dynamic> json) {
    return ErrorMassegeModel(message: json['message'],errors: json['errors']);
  }
}
