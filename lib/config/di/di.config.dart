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
import 'di.dart' as _i913;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i620.RegisterApiService>(
      () => _i620.RegisterApiService(gh<_i361.Dio>()),
    );
    gh.factory<_i755.RegisterRemoteDatasourceContract>(
      () => _i568.RegisterRemoteDatasourceImpl(gh<_i620.RegisterApiService>()),
    );
    gh.factory<_i628.RegisterRepoContract>(
      () =>
          _i820.RegisterRepoImpl(gh<_i755.RegisterRemoteDatasourceContract>()),
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

class _$DioModule extends _i913.DioModule {}
