import 'package:injectable/injectable.dart';

import '../models/login_response_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponseModel> login(String email, String password);
}