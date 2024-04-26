class UserAppointment {
  int? id;
  String? scheduleDate;
  int? unitId;
  String? userId;
  String? whatsappNumber;
  String? email;
  bool? isApproved;
  String? user;
  String? unit;

  UserAppointment(
      {this.id,
      this.scheduleDate,
      this.unitId,
      this.userId,
      this.whatsappNumber,
      this.email,
      this.isApproved,
      this.user,
      this.unit});

  UserAppointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleDate = json['scheduleDate'];
    unitId = json['unitId'];
    userId = json['userId'];
    whatsappNumber = json['whatsappNumber'];
    email = json['email'];
    isApproved = json['isApproved'];
    user = json['user'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new  Map<String, dynamic>();
    data['id'] = this.id;
    data['scheduleDate'] = this.scheduleDate;
    data['unitId'] = this.unitId;
    data['userId'] = this.userId;
    data['whatsappNumber'] = this.whatsappNumber;
    data['email'] = this.email;
    data['isApproved'] = this.isApproved;
    data['user'] = this.user;
    data['unit'] = this.unit;
    return data;
  }
}