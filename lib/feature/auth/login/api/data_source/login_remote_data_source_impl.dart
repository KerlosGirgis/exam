import 'package:dio/dio.dart';
import 'package:exam/core/constant/end_point.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/login_response_model.dart';
import '../../data/datasources/login_remote_data_source.dart';


@Injectable(as: LoginRemoteDataSource)

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSourceImpl(this.dio);

  @override
  Future<LoginResponseModel> login(
      String email,
      String password,
      ) async {
    final response = await dio.post(
      EndPoint.loginUrl,
      data: {
        "email": email,
        "password": password,
      },
    );

    return LoginResponseModel.fromJson(response.data);
  }
}