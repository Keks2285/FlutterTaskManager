import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class AuthRepositories{

  Future<Either<String,DefaultFailure>> signIn(String login, String password);
  
  Future<Either<String,bool>> signUp(String login, String password, String lastName,String firstName,String middleName,String email);
}
