import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/Explore/domain/entities/unit_entity.dart';
import 'package:realestate/Features/Favorites/domain/use_cases/get_favorit_list_usecase.dart';
import 'package:realestate/Features/Favorites/domain/use_cases/remove_from_favorit_usecas.dart';
import 'package:realestate/core/error/failure.dart';
import 'package:realestate/core/widgets/custom_daliog.dart';

part 'get_favorits_state.dart';

class GetFavoritsCubit extends Cubit<GetFavoritsState> {
  GetFavoritsCubit(
      {required this.getFavoritUsecse,
      required this.removeFromFavoritListUsecase})
      : super(GetFavoritsInitial());
  final GetFavoritUsecse getFavoritUsecse;
  final RemoveFromFavoritListUsecase removeFromFavoritListUsecase;
  Future<void> getFavoirts(String userId) async {
    emit(GetFavoirtIsloading());
    try {
      Either<Failure, List<UnitEntity>> favoirts =
          await getFavoritUsecse.call(userId);
      emit(favoirts.fold((l) => GetFavoirtError(favorts: _mapFailureToMsg(l)),
          (r) => GetFavoirtSuccess(favorts: r)));
    } catch (e) {
      emit(GetFavoirtError(favorts: e.toString()));
    }
  }

  //remove Favorit
  Future<void> removefromFavoirts(String userId, int id) async {
    emit(RemoveFavoritIsLoading());
    try {
      Either<Failure, String> favoirts =
          await removeFromFavoritListUsecase.call(userId, id);
      log(favoirts.toString());
      emit(favoirts.fold((l) => RemoveFavoirtError(error: _mapFailureToMsg(l)),
          (r) => RemovefavoirtSucces(success: r)));
    } catch (e) {
      emit(RemoveFavoirtError(error: e.toString()));
    }
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
  void showCustomDialog(BuildContext context,  state,
      VoidCallback onpresed) {
    //  emit(ShowCustomDialogState());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            alretTitle: state.toString(),
            onPresed: onpresed,
          );
        });
  }
}
