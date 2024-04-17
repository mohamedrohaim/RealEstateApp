import 'package:dartz/dartz.dart';
import 'package:realestate/Features/Auth/data/model/login_model.dart';

abstract class LoginUserRepo {
  Future<Either<String, LoginModel>> loginUser(String email,String password,bool? isFormData);
}
