import '../../../../../config/base_response/base_response.dart';
import '../entities/user_entity.dart';

abstract class LoginRepository {
  Future<BaseResponse<(User, String)>> login(
    String email,
    String password, {
    required bool rememberMe,
  });
}
