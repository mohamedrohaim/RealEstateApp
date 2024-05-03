import 'package:realestate/Features/Profile/domain/entities/user_appointments_entity.dart';
import 'package:realestate/core/network/api_constatn.dart';
import 'package:realestate/core/network/api_helper.dart';

abstract class ProfileRmoeteData {
  Future<List<UserAppointment>> getAppointments(String userId);
}

class ProfileRemotedataImpl implements ProfileRmoeteData {
  //final APIHelper apiHelper;
  //ProfileRemotedataImpl({required this.apiHelper});
  @override
  Future<List<UserAppointment>> getAppointments(String userId) async {
    final response = await APIHelper.getScheduleAppointment(userId);
    List<UserAppointment> list =
        (response).map((value) => UserAppointment.fromJson(value)).toList();
    return list;
  }
}
