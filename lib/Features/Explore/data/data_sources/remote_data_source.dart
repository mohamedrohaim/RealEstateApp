import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:realestate/Features/Explore/data/models/unit_by_id_model.dart';
import 'package:realestate/Features/Explore/data/models/unit_model.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_by_id.dart';
import 'package:realestate/core/network/api_constatn.dart';
import 'package:realestate/core/network/api_helper.dart';
import 'package:realestate/core/network/dio_helper.dart';
import 'package:realestate/core/network/fetch_data.dart';

abstract class RemoteDataSource {
  Future<List<UnitMdel>> getUnit();
  Future<UnitById> getUnitById(int id, String userId);
  Future<String> addTofavoirt(int id, String userID);
  Future<String> addAppointment(String scheduleDate, int unitId, String userId,
      String whatsappnumber, String email, bool isApproved);
  Future<List<UnitMdel>?> searchFilter(
      String? title, String? governate, int? priceFrom, int? priceTo);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final APIHelper apiHelper;
  RemoteDataSourceImpl({required this.apiHelper});
  @override
  Future<List<UnitMdel>> getUnit() async {
    final response = await APIHelper.getData(
      url: APIConstant.getUnit,
    );
    log("data source1" + response.toString());
    List<UnitMdel> list =
        (response).map((item) => UnitMdel.fromJson(item)).toList();
    log(list.toString());
    return list;
  }

  @override
  Future<UnitById> getUnitById(int id, String userId) async {
    var response = await APIHelper.fetchData(id, userId);
    log("data source1" + response.toString());
    UnitById unitByIdModel = UnitById.fromJson(response.data);
    log(unitByIdModel.toString());
    return unitByIdModel;
  }

  @override
  Future<String> addTofavoirt(int id, String userID) async {
    final response = await DioHelper.postUser(
      query: {"userId": userID, "unitId": id},
      url: APIConstant.addtoFavoirt,
    );
    log(response.toString());
    return response.toString();
  }

  @override
  Future<String> addAppointment(String scheduleDate, int unitId, String userId,
      String whatsappnumber, String email, bool isApproved) async {
    final response =
        await DioHelper.postUser(url: APIConstant.addAppointment, data: {
      "scheduleDate": scheduleDate,
      "unitId": unitId,
      "userId": userId,
      "whatsappNumber": whatsappnumber,
      "email": email,
      "isApproved": true
    });
    return response.data;
  }

  @override
  Future<List<UnitMdel>?> searchFilter(
      String? title, String? governate, int? priceFrom, int? priceTo) async {
    List<UnitMdel> outputunits = [];
    //defualt search with title only
    if (governate!.isEmpty && priceFrom == null && priceTo == null) {
      log('defualt search');
      final response = await APIHelper.filterSearch(
          url: APIConstant.filterUnit,
          data: {
            "title": title,
            "governate": '',
            "priceFrom": null,
            "priceTo": null
          });
      List<UnitMdel> units =
          (response).map((item) => UnitMdel.fromJson(item)).toList();
      outputunits = units;
      return units;
      //search with title and governate
    } else if (title!.isNotEmpty && governate.isNotEmpty&& priceFrom == null && priceTo == null) {
      log('search with title and governate');
      final response = await APIHelper.filterSearch(
          url: APIConstant.filterUnit,
          data: {
            "title": title,
            "governate": governate,
            "priceFrom": null,
            "priceTo": null
          });
      List<UnitMdel> units =
          (response).map((item) => UnitMdel.fromJson(item)).toList();
      outputunits = units;
      return outputunits;
      //searhc with title and price and location
    } else if (title.isNotEmpty &&
        governate.isNotEmpty &&
        priceFrom != null &&
        priceTo != null) {
      log('price and Location search');
      final response =
          await APIHelper.filterSearch(url: APIConstant.filterUnit, data: {
        "title": title,
        "governate": governate,
        "priceFrom": priceFrom,
        "priceTo": priceTo
      });
      List<UnitMdel> units =
          (response).map((item) => UnitMdel.fromJson(item)).toList();
      outputunits = units;
      return units;
      //searhc with title and price
    } else if (governate.isEmpty && priceFrom != null && priceTo != null) {
      log('price search');
      final response = await APIHelper.filterSearch(
          url: APIConstant.filterUnit,
          data: {
            "title": title,
            "governate": "",
            "priceFrom": priceFrom,
            "priceTo": priceTo
          });
      List<UnitMdel> units =
          (response).map((item) => UnitMdel.fromJson(item)).toList();
      outputunits = units;
      log(unit.toString());
      return units;
    }
  }
}
