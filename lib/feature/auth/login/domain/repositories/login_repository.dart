import '../entities/user_entity.dart';

abstract class LoginRepository {
  Future<(User,String)> login(String email, String password);
}