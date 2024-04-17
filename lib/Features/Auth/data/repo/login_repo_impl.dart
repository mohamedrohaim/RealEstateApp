// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:realestate/Features/Auth/data/model/login_model.dart';
// import 'package:realestate/Features/Auth/data/repo/login_repo.dart';
// import 'package:realestate/core/error/failure.dart';
// import 'package:realestate/core/network/api_constatn.dart';
// import 'package:realestate/core/network/dio_helper.dart';


// class LoginUserRepoImpl extends LoginUserRepo {
//   @override
//   Future<Either<String, LoginModel>> loginUser(
//       String email, String password,bool? isFormData) async {
//     try {
//       var response = await DioHelper.postData(url: APIConstant.loginUrl, data: {
//         "email":email,
//         "password":password
//       });
//       final user = LoginModel.fromJson(response.data);
//       return Right(user);
//     } catch (e) {
//       if (e is DioException) {
//         return Left(handleDioExceptions(e));
//       }
        
//       return Left(e.toString());
//     }
//   }
// }
