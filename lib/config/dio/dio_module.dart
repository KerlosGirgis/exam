import 'package:exam/core/constant/end_point.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@module
abstract class ExternalOperationsModule {
  @singleton
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: EndPoint.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
}
