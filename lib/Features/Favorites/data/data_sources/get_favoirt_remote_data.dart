import 'dart:developer';

import 'package:realestate/Features/Explore/data/models/unit_model.dart';
import 'package:realestate/core/network/api_constatn.dart';
import 'package:realestate/core/network/api_helper.dart';
import 'package:realestate/core/network/dio_helper.dart';

abstract class GetFavoritRemoteData {
  Future<List<UnitMdel>> getFavoirt(String userId);
  Future<String> removeFromFavoirtList(String userId, int id);
}

class GetFavoritRemoteDataimpl implements GetFavoritRemoteData {
  final APIHelper apiHelper;
  GetFavoritRemoteDataimpl({required this.apiHelper});
  @override
  Future<List<UnitMdel>> getFavoirt(String userId) async {
    // final response = await DioHelper.getData(
    //     url: APIConstant.getFavoirts, query: {"userId": userId});
    final response = await APIHelper.getData(
        url: APIConstant.getFavoirts, param: {"userId": userId});
    log("data source1" + response.toString());
    List<UnitMdel> list =
        (response).map((item) => UnitMdel.fromJson(item)).toList();
    //List<UnitMdel> list = ;
    //log(list.toString());
    return list;
  }

  @override
  Future<String> removeFromFavoirtList(String userId, int id) async {
    final reponse = await APIHelper.postData({
      "userId": userId,
      "unitId": id,
    }, APIConstant.baseUrl + APIConstant.removefromfavoritList);
    // final response =
    //     await DioHelper.postUser(url: APIConstant.removefromfavoritList, data: {
    //   "userId": userId,
    //   "unitId": id,
    // });
    log(reponse.toString());
    return reponse.toString();
  }
}
