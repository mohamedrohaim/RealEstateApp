import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestate/Features/AI/data/data_sources/success_model.dart';
import 'package:realestate/core/network/api_helper.dart';
import 'package:realestate/core/widgets/custom_daliog.dart';

part 'predict_price_state.dart';

class PredictPriceCubit extends Cubit<PredictPriceState> {
  PredictPriceCubit() : super(PredictPriceInitial());
  Future<void> predictPrice(String type, furnished, rent, city, region,
      int area, badrooms, bathrooms, level) async {
    emit(PredictedIsLoading());
    try {
      var response = await APIHelper.aiPredict({
        "type": [type],
        "area": [area],
        "bedrooms": [badrooms],
        "bathrooms": [badrooms],
        "level": [level],
        "furnished": [furnished],
        "rent": [rent],
        "city": [city],
        "region": [region]
      });
      log(response.data.toString());
      if (response.statusCode == 400) {
        log(response.data.toString());
        emit(PredictedErrorState(error: response.data));
      }
      var output = PredictedSuccesModel.fromJson(response.data);
      emit(PredictedSuccesState(predictedSuccesModel: output));
    } catch (e) {
      emit(PredictedErrorState(error: e.toString()));
    }
  }

  void showCustomDialog(
      BuildContext context, PredictedSuccesState state, VoidCallback onpresed) {
    //  emit(ShowCustomDialogState());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            alretTitle: "Your Predict Price " +
                state.predictedSuccesModel.predicted_price.toString(),
            onPresed: onpresed,
          );
        });
  }
}
