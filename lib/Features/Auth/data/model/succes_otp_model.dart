class OTPSendSuccess{
   String? message;
   String? restPasswordToken;
   String? email;
   OTPSendSuccess({
     this.message,
      this.restPasswordToken,
      this.email});
      factory OTPSendSuccess.fromJson(Map<String,dynamic>json){
        return OTPSendSuccess(message: json['message'],restPasswordToken: json['resetPasswordToken'],email: json['email']);
      }
}