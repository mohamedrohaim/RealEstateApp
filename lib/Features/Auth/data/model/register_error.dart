class RegisterError {
  String? type;
  String? title;
  int? status;
  String? traceId;
  Errors? errors;

  RegisterError(
      {this.type, this.title, this.status, this.traceId, this.errors});

  factory RegisterError.fromJson(Map<String, dynamic> json) {
    return RegisterError(
        type: json['type'],
        title: json['title'],
        status: json['status'],
        traceId: json['traceId'],
        errors:
            json['errors'] != null ? Errors.fromJson(json['errors']) : null);
    // type = json['type'];
    // title = json['title'];
    // status = json['status'];
    // traceId = json['traceId'];
    // errors =
    //     json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['type'] = this.type;
  //   data['title'] = this.title;
  //   data['status'] = this.status;
  //   data['traceId'] = this.traceId;
  //   if (this.errors != null) {
  //     data['errors'] = this.errors!.toJson();
  //   }
  //   return data;
  // }
}

class Errors {
  List<String>? governate;

  Errors({this.governate});

  factory Errors.fromJson(Map<String, dynamic> json) {
    return Errors(governate: json['Governate'].cast<String>());
  }
//governate = json['Governate'].cast<String>();
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['Governate'] = this.governate;
  //   return data;
  // }
}
