// import 'package:dio/dio.dart';
// import 'package:mo_project/Features/Auth/data/model/error_model.dart';
// class ServerException implements Exception {
//   String? errorMessage;

//   ServerException({this.errorMessage});
// }

// handleDioExceptions(DioException e) {
//   switch (e.type) {
//     case DioExceptionType.connectionTimeout:
//       throw ServerException(
//           errorMessage: 'connection time out please try again');
//     case DioExceptionType.sendTimeout:
//       throw ServerException(errorMessage: 'send time out please try again');
//     case DioExceptionType.receiveTimeout:
//       throw ServerException(errorMessage: 'receiveTimeout');
//     case DioExceptionType.badCertificate:
//       throw ServerException(errorMessage: 'not certified');
//     case DioExceptionType.cancel:
//       throw ServerException(errorMessage: 'call to api cancelled');
//     case DioExceptionType.connectionError:
//       throw ServerException(errorMessage: 'no internet connection');
//     case DioExceptionType.unknown:
//       throw ServerException(
//           errorMessage: 'Unexpected Error,Please try again later');
//     case DioExceptionType.badResponse:
//       switch (e.response?.statusCode) {
//         case 404:
//         case 400:
//         case 401:
//         case 403:
//         case 409:
//         case 422:
//         case 504:
//           final errorModel = ErrorModel.fromJson(e.response!.data);
//           return errorModel.emailError??errorModel.passwordError;
//         default:
//           throw ServerException(
//             errorMessage: 'Unexpected Error,Please try again later',
//           );
//       }
//   }
// }
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}