class PredictedSuccesModel {
  final double predicted_price;
  PredictedSuccesModel({required this.predicted_price});
  factory PredictedSuccesModel.fromJson(Map<String, dynamic> json) {
    return PredictedSuccesModel(predicted_price: json['predicted_price']);
  }
}
