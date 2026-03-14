// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
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
import '../dio/dio_module.dart' as _i977;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final externalOperationsModule = _$ExternalOperationsModule();
    gh.singleton<_i361.Dio>(() => externalOperationsModule.dio);
    gh.factory<_i439.ForgetPasswordApiClient>(
      () => _i439.ForgetPasswordApiClient(gh<_i361.Dio>()),
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
    gh.factory<_i944.ForgetPasswordUseCase>(
      () => _i944.ForgetPasswordUseCase(gh<_i907.ForgetPasswordRepoContract>()),
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
    gh.factory<_i1036.ResetPasswordCubit>(
      () => _i1036.ResetPasswordCubit(gh<_i756.ResetPasswordUseCase>()),
    );
    return this;
  }
}

class _$ExternalOperationsModule extends _i977.ExternalOperationsModule {}
