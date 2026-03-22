// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../feature/auth/forget_password/api/data_sources/forget_password_remote_data_sources_impl.dart'
    as _i913;
import '../../feature/auth/forget_password/api/forget_password_api_client/forget_password_api_client.dart'
    as _i439;
import '../../feature/auth/forget_password/data/data_sources/forget_password_remote_data_sources_contract.dart'
    as _i32;
import '../../feature/auth/forget_password/data/repo/forget_password_repo_impl.dart'
    as _i710;
import '../../feature/auth/forget_password/domain/repo/forget_password_repo_contract.dart'
    as _i907;
import '../../feature/auth/forget_password/domain/use_case/forget_password_use_case.dart'
    as _i944;
import '../../feature/auth/forget_password/domain/use_case/reset_password_use_case.dart'
    as _i756;
import '../../feature/auth/forget_password/domain/use_case/verify_reset_code_use_case.dart'
    as _i511;
import '../../feature/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart'
    as _i777;
import '../../feature/auth/forget_password/presentation/view_model/cubit/reset_password_cubit.dart'
    as _i1036;
import '../../feature/auth/forget_password/presentation/view_model/cubit/verification_cubit.dart'
    as _i700;
import '../../feature/auth/login/api/data_source/login_remote_data_source_impl.dart'
    as _i359;
import '../../feature/auth/login/api/login_api_client/login_api_client.dart'
    as _i1057;
import '../../feature/auth/login/data/datasources/login_local_data_source.dart'
    as _i51;
import '../../feature/auth/login/data/datasources/login_remote_data_source.dart'
    as _i493;
import '../../feature/auth/login/data/repositories/login_repository_impl.dart'
    as _i393;
import '../../feature/auth/login/domain/repositories/login_repository.dart'
    as _i914;
import '../../feature/auth/login/domain/usecases/login_usecase.dart' as _i58;
import '../../feature/auth/login/presentation/Bloc/login_bloc.dart' as _i1018;
import '../../feature/auth/register/api/apiServices/api_services.dart' as _i620;
import '../../feature/auth/register/api/dataSource/register_remote_datasource_impl.dart'
    as _i568;
import '../../feature/auth/register/data/dataSource/register_remote_datasource_contract.dart'
    as _i755;
import '../../feature/auth/register/data/repo/register_repo_impl.dart' as _i820;
import '../../feature/auth/register/domain/repo/register_repo_contract.dart'
    as _i628;
import '../../feature/auth/register/domain/useCases/register_usecase.dart'
    as _i62;
import '../../feature/auth/register/presentation/viewModel/register_cubit.dart'
    as _i583;
import '../dio/dio_module.dart' as _i977;
import 'storage_module.dart' as _i371;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final dioModule = _$DioModule();
    gh.singleton<_i558.FlutterSecureStorage>(() => storageModule.storage);
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i493.LoginRemoteDataSource>(
      () => _i359.LoginRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i51.LoginLocalDataSource>(
      () => _i51.LoginLocalDataSourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i439.ForgetPasswordApiClient>(
      () => _i439.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i1057.LoginApiClient>(
      () => _i1057.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i620.RegisterApiService>(
      () => _i620.RegisterApiService(gh<_i361.Dio>()),
    );
    gh.factory<_i32.ForgetPasswordRemoteDataSourcesContract>(
      () => _i913.ForgetPasswordRemoteDataSourcesImpl(
        gh<_i439.ForgetPasswordApiClient>(),
      ),
    );
    gh.factory<_i907.ForgetPasswordRepoContract>(
      () => _i710.ForgetPasswordRepoImpl(
        gh<_i32.ForgetPasswordRemoteDataSourcesContract>(),
      ),
    );
    gh.factory<_i914.LoginRepository>(
      () => _i393.LoginRepositoryImpl(
        gh<_i493.LoginRemoteDataSource>(),
        gh<_i51.LoginLocalDataSource>(),
      ),
    );
    gh.factory<_i944.ForgetPasswordUseCase>(
      () => _i944.ForgetPasswordUseCase(gh<_i907.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i755.RegisterRemoteDatasourceContract>(
      () => _i568.RegisterRemoteDatasourceImpl(gh<_i620.RegisterApiService>()),
    );
    gh.lazySingleton<_i756.ResetPasswordUseCase>(
      () => _i756.ResetPasswordUseCase(gh<_i907.ForgetPasswordRepoContract>()),
    );
    gh.lazySingleton<_i511.VerifyResetCodeUseCase>(
      () =>
          _i511.VerifyResetCodeUseCase(gh<_i907.ForgetPasswordRepoContract>()),
    );
    gh.factory<_i777.ForgetPasswordCubit>(
      () => _i777.ForgetPasswordCubit(gh<_i944.ForgetPasswordUseCase>()),
    );
    gh.factory<_i700.VerificationCubit>(
      () => _i700.VerificationCubit(gh<_i511.VerifyResetCodeUseCase>()),
    );
    gh.factory<_i58.LoginUseCase>(
      () => _i58.LoginUseCase(gh<_i914.LoginRepository>()),
    );
    gh.factory<_i1018.LoginBloc>(
      () => _i1018.LoginBloc(gh<_i58.LoginUseCase>()),
    );
    gh.factory<_i628.RegisterRepoContract>(
      () =>
          _i820.RegisterRepoImpl(gh<_i755.RegisterRemoteDatasourceContract>()),
    );
    gh.factory<_i1036.ResetPasswordCubit>(
      () => _i1036.ResetPasswordCubit(gh<_i756.ResetPasswordUseCase>()),
    );
    gh.factory<_i62.RegisterUsecase>(
      () => _i62.RegisterUsecase(gh<_i628.RegisterRepoContract>()),
    );
    gh.factory<_i583.RegisterCubit>(
      () => _i583.RegisterCubit(gh<_i62.RegisterUsecase>()),
    );
    return this;
  }
}

class _$StorageModule extends _i371.StorageModule {}

class _$DioModule extends _i977.DioModule {}
