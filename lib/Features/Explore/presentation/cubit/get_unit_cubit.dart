import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_by_id.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';
import 'package:realestate/Features/Explore/domain/use_cases/add_to_favoirt_usecase.dart';
import 'package:realestate/Features/Explore/domain/use_cases/get_unit_by_id_usecase.dart';
import 'package:realestate/Features/Explore/domain/use_cases/get_unit_usecase.dart';
import 'package:realestate/core/error/failure.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/widgets/custom_daliog.dart';

part 'get_unit_state.dart';

class GetUnitCubit extends Cubit<GetUnitState> {
  final GetUnitUseCase getUnitUseCase;
  final GetUnitByIdUseCase getUnitByIdUseCase;
  final AddToFavoritUsecase addToFavoritUsecase;
  GetUnitCubit(
      {required this.getUnitUseCase,
      required this.getUnitByIdUseCase,
      required this.addToFavoritUsecase})
      : super(GetUnitInitial());
  Future<void> getUnit() async {
    try {
      Either<Failure, List<UnitEntity>> response = await getUnitUseCase.call();
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
