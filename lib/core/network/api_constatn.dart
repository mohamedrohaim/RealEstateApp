class APIConstant {
  static const String baseUrl =
      "http://realestateegv1.runasp.net";
  static const String loginUrl = "/api/Account/login";
  static const String registerUrl = "/api/Account/register";
  static const String confrimEmailOTP = "/api/Account/confirmEmail";
  // static const String sendOTPResetPassword = "/api/Account/sendOtpRestPassword";
  static const String sendOTPForgetPassword =
      "/api/Account/sendOtpRestPassword";
  static const String verfiyOTPForgetPassword =
      "/api/Account/verifyOtpForgetPassword";
  //static const String resetForgetPassword = "api/Account/";
  static const String getUnit = "/api/Unit";
  static const String getUnitById = '/api/Unit';
  static const String addtoFavoirt = "/api/Unit/add-favorite";
  static const String getFavoirts = "/api/Unit/favorite-list";
  static const String removefromfavoritList = "/api/Unit/remove-favorite";
  static const String resetPassword = "/api/Account/resetForgetPassword";
  static const String addAppointment = '/api/ScheduleAppointment/create';
    static const String getAppointment = '/api/ScheduleAppointment/user/';
    static const String filterUnit = '/api/Unit/FilterUnits'; 
}
//  'https://realestate20240404164946.azurewebsites.net/api/Unit/remove-favorite?userId=9974c671-833b-4651--cf37eee78d7c&unitId=6' \
