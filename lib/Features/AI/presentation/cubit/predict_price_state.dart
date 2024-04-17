part of 'predict_price_cubit.dart';

sealed class PredictPriceState extends Equatable {
  const PredictPriceState();

  @override
  List<Object> get props => [];
}

final class PredictPriceInitial extends PredictPriceState {}
class PredictedIsLoading extends PredictPriceState{}
class PredictedErrorState extends PredictPriceState {
  final String error;
  PredictedErrorState({required this.error});
}

class PredictedSuccesState extends PredictPriceState {
  final PredictedSuccesModel predictedSuccesModel;
  PredictedSuccesState({required this.predictedSuccesModel});
}
