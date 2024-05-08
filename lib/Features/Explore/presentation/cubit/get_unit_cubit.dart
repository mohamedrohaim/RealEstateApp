import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Explore/domain/entities/groubed_by_category.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_by_id.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';
import 'package:realestate/Features/Explore/domain/use_cases/add_appointment_usecase.dart';
import 'package:realestate/Features/Explore/domain/use_cases/add_to_favoirt_usecase.dart';
import 'package:realestate/Features/Explore/domain/use_cases/filter_search_usecase.dart';
import 'package:realestate/Features/Explore/domain/use_cases/get_unit_by_id_usecase.dart';
import 'package:realestate/Features/Explore/domain/use_cases/get_unit_usecase.dart';
import 'package:realestate/core/error/failure.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/widgets/custom_daliog.dart';
import 'package:sqflite/sqflite.dart';

part 'get_unit_state.dart';

class GetUnitCubit extends Cubit<GetUnitState> {
  final GetUnitUseCase getUnitUseCase;
  final GetUnitByIdUseCase getUnitByIdUseCase;
  final AddToFavoritUsecase addToFavoritUsecase;
  final AddAppointmentUseCase addAppointmentUseCase;
  final FilterSearchUsCase filterSearchUsCase;
  GetUnitCubit(
      {required this.getUnitUseCase,
      required this.getUnitByIdUseCase,
      required this.addToFavoritUsecase,
      required this.addAppointmentUseCase,required this.filterSearchUsCase})
      : super(GetUnitInitial());
  List<UnitEntity> units = [];
  Future<void> getUnit() async {
    try {
      Either<Failure, List<UnitEntity>> response = await getUnitUseCase.call();
      response.fold(
        (l) => emit(GetUnitErrorState(error: _mapFailureToMsg(l))),
        (r) {
          Map<String, List<UnitEntity>> groupedUnits = {};
          r.forEach((unit) {
            if (!groupedUnits.containsKey(unit.unitCategoryName)) {
              groupedUnits[unit.unitCategoryName] = [];
            }
            groupedUnits[unit.unitCategoryName]!.add(unit);
          });
          List<UnitsGroupedByCategory> unitGroupedByCategory = [];
          groupedUnits.forEach((category, unit) {
            unitGroupedByCategory
                .add(UnitsGroupedByCategory(category: category, units: units));
          });
          // Assigning the list of products to the product list
          emit(GetUnitSuccessState(units: r));
        },
      );
      //we need it
      // if (response.isRight()) {
      //   List<UnitEntity> units = response.getOrElse(() => []);
      //   emit(GetUnitSuccessState(units: units));
      // } else if (response.isLeft()) {
      //   var failure = response.getOrElse(() => []);
      //   emit(GetUnitErrorState(error: failure.toString()));
      //   //  _mapFailureToMsg();
      // }
      emit(response.fold((l) => GetUnitErrorState(error: _mapFailureToMsg(l)),
          (r) => GetUnitSuccessState(units: r)));
    } catch (e) {
      emit(GetUnitErrorState(error: e.toString()));
    }
  }

  Future<void> getUnitById(int id, String userID) async {
    try {
      log('start cubit');
      // String userId =await CacheHelper.getData(key: 'UserID');
      Either<Failure, UnitById> unitById =
          await getUnitByIdUseCase.call(id, userID);
      log(userID);
      log(unitById.toString());
      emit(unitById.fold(
          (l) => GetUnitByIdErrorState(error: _mapFailureToMsg(l)),
          (r) => GetUnitByIdSuccess(unitByIDEntity: r)));
    } catch (e) {
      emit(GetUnitByIdErrorState(error: e.toString()));
    }
  }

  Future<void> addToFavoirt(int id, String userId) async {
    emit(AddToFavortiIsloading());
    try {
      Either<Failure, String> response =
          await addToFavoritUsecase.call(id, userId);
      emit(response.fold(
          (l) => AddtoFavoriteErrorState(error: _mapFailureToMsg(l)),
          (r) => AddtoFavoriteSuccesState(success: r)));
    } catch (e) {
      emit(AddtoFavoriteErrorState(error: e.toString()));
    }
  }

  List<UnitsGroupedByCategory> groupUnitsByCategory(
      List<UnitEntity> units, String categoryToGroupBy) {
    Map<String, List<UnitEntity>> groupedUnits = {};
    units.forEach((unit) {
      if (unit.unitCategoryName == categoryToGroupBy) {
        if (!groupedUnits.containsKey(unit.unitCategoryName)) {
          groupedUnits[unit.unitCategoryName] = [];
        }
        groupedUnits[unit.unitCategoryName]!.add(unit);
      }
    });

    List<UnitsGroupedByCategory> unitsGroupedByCategory = [];
    groupedUnits.forEach((category, units) {
      unitsGroupedByCategory.add(
        UnitsGroupedByCategory(category: category, units: units),
      );
    });

    return unitsGroupedByCategory;
  }

  Future<void> getAndGroupUnits(String categoryToGroupBy) async {
    try {
      Either<Failure, List<UnitEntity>> response = await getUnitUseCase.call();
      response.fold(
        (l) => emit(GetUnitErrorState(error: _mapFailureToMsg(l))),
        (r) {
          List<UnitsGroupedByCategory> unitsGroupedByCategory =
              groupUnitsByCategory(r, categoryToGroupBy);
          emit(GetUnitsByCategoryGrouped(unitCategory: unitsGroupedByCategory));
        },
      );
    } catch (e) {
      emit(GetUnitErrorState(error: e.toString()));
    }
  }

  Future<void> addAppointment(String scheduleDate, int unitId, String userId,
      String whatsappnumber, String email, bool isApproved) async {
    emit(AddAppointmentIsLoading());
    try {
      Either<String, String> response = await addAppointmentUseCase.call(
          scheduleDate, unitId, userId, whatsappnumber, email, isApproved);
      emit(response.fold((l) => AddAppointmentIsError(), (r) => AddAppointmnetIsSuccess()));
    } catch (error) {
      if (error is DioException) {
        emit(AddAppointmentIsError());
      }
      throw error;
    }
  }
 Future<void> searchFiter(
      String? title, String? governate, int? priceFrom, int? priceTo) async {
    emit(FiterSearchIsLoadingState());
    try {
      Either<Failure, List<UnitEntity>?> response =
          await filterSearchUsCase.call(title, governate, priceFrom, priceTo);
      emit(response.fold(
          (l) => FiterSearchIsErrorState(error: _mapFailureToMsg(l)),
          (r) => FiterSearchIsSuccessState(units: r!)));   
    } catch (error) {
      if (error is DioException) {
        emit(FiterSearchIsErrorState(error: error.toString()));
      }
      throw error;  
    }
  }
  void showCustomDialog(
      BuildContext context, String state, VoidCallback onpresed) {
    //  emit(ShowCustomDialogState());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            alretTitle: state,
            onPresed: onpresed,
          );
        });
  }

  Database? dataBase;
  List<Map> recentView = [];
  void createDatabase() {
    openDatabase(
      'recent.db',
      version: 1,
      onCreate: (database, version) {
        log('database created');
        database
            .execute(
                'CREATE TABLE recentView (id INTEGER PRIMARY KEY, title TEXT, price TEXT, image TEXT,status TEXT )')
            .then((value) {
          log('table created');
        }).catchError((error) {
          log('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        log('database opened');
      },
    ).then((value) {
      dataBase = value;
      emit(AppCreateDatabaseState());
    });
  }

  Future<void> insertToDatabase(
    String title,
    String price,
    String image,
  ) async {
    await dataBase!.transaction((txn) async {
      await txn
          .rawInsert(
        'INSERT INTO recentView(title, price, image,status) VALUES("$title", "$price", "$image","new")',
      )
          .then((value) {
        print('$value inserted successfully');
        // emit(AppInsertDatabaseState());

        getDataFromDatabase(dataBase);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    recentView = [];

    //  emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM recentView').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') recentView.add(element);
        log(recentView.first.toString());
      });
      log("after add" + recentView.first.toString());
      emit(AppGetDatabaseState(recentViwe: recentView));
    });
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ServerFailure";
      case CacheFailure:
        return "CacheFailure";
      default:
        return "unexpectedError";
    }
  }
}
