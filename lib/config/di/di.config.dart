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

import '../../core/storage/hive_storage.dart' as _i526;
import '../../core/storage/hive_storage_contract.dart' as _i637;
import '../../core/storage/secure_storage.dart' as _i108;
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
import '../../feature/auth/register/domain/useCases/register_use_case.dart'
    as _i198;
import '../../feature/auth/register/presentation/viewModel/register_cubit.dart'
    as _i583;
import '../../feature/exam/api/data_sources/exam_local_data_source_impl.dart'
    as _i840;
import '../../feature/exam/api/data_sources/exam_remote_data_source_impl.dart'
    as _i589;
import '../../feature/exam/api/exam_api_client/exam_api_client.dart' as _i922;
import '../../feature/exam/data/data_sources/exam_local_data_source_contract.dart'
    as _i1012;
import '../../feature/exam/data/data_sources/exam_remote_data_source_contract.dart'
    as _i191;
import '../../feature/exam/data/repo/exam_repo_impl.dart' as _i94;
import '../../feature/exam/domain/repo/exam_repo_contract.dart' as _i345;
import '../../feature/exam/domain/use_cases/get_exam_questions_use_case.dart'
    as _i43;
import '../../feature/exam/domain/use_cases/store_exam_result_use_case.dart'
    as _i307;
import '../../feature/exam/presentation/Bloc/exam_bloc.dart' as _i635;
import '../../feature/exam_subject/api/data_sources/exam_subject_remote_data_sources_impl.dart'
    as _i869;
import '../../feature/exam_subject/api/exam_subject_api_client/exam_subject_api_client.dart'
    as _i199;
import '../../feature/exam_subject/data/data_sources/exam_subject_remote_data_sources_contract.dart'
    as _i188;
import '../../feature/exam_subject/data/repo/exam_subject_repo_impl.dart'
    as _i919;
import '../../feature/exam_subject/domain/repo/exam_subject_repo_contract.dart'
    as _i1010;
import '../../feature/exam_subject/domain/use_case/exam_subject_use_case.dart'
    as _i930;
import '../../feature/exam_subject/presentation/view_model/cubit/exam_subject_cubit.dart'
    as _i870;
import '../../feature/explore/api/data_source/explore_remote_datasource_impl.dart'
    as _i508;
import '../../feature/explore/api/services/explore_services.dart' as _i461;
import '../../feature/explore/data/data_source/explore_remote_datasource.dart'
    as _i407;
import '../../feature/explore/data/repo/explore_repo_impl.dart' as _i495;
import '../../feature/explore/domain/repo/explore_repo_contract.dart' as _i679;
import '../../feature/explore/domain/usecase/subjects_use_case.dart' as _i281;
import '../../feature/explore/presentation/view_model/explore_cubit.dart'
    as _i696;
import '../../feature/profile/api/data_sources/profile_remote_data_source_impl.dart'
    as _i711;
import '../../feature/profile/api/profile_api_client/profile_api_client.dart'
    as _i365;
import '../../feature/profile/data/data_sources/profile_remote_data_source_contract.dart'
    as _i208;
import '../../feature/profile/data/repo/profile_repo_impl.dart' as _i341;
import '../../feature/profile/domain/repo/profile_repo_contract.dart' as _i334;
import '../../feature/profile/domain/use_case/edit_profile_use_case.dart'
    as _i36;
import '../../feature/profile/domain/use_case/get_user_profile_use_case.dart'
    as _i736;
import '../../feature/profile/presentation/view_model/cubit/profile_cubit.dart'
    as _i784;
import '../../feature/profile_change_password/api/data_source/change_password_remote_data_source_impl.dart'
    as _i416;
import '../../feature/profile_change_password/api/services/change_password_service.dart'
    as _i225;
import '../../feature/profile_change_password/data/data_source/change_password_remote_data_source.dart'
    as _i643;
import '../../feature/profile_change_password/data/repo/change_password_repo_impl.dart'
    as _i942;
import '../../feature/profile_change_password/domain/repo/change_password_repo.dart'
    as _i38;
import '../../feature/profile_change_password/domain/usecase/change_password_use_case.dart'
    as _i529;
import '../../feature/profile_change_password/presentation/view_model/change_password_cubit.dart'
    as _i757;
import '../../feature/results/api/data_sources/results_local_data_source_impl.dart'
    as _i803;
import '../../feature/results/api/data_sources/results_remote_data_source_impl.dart'
    as _i649;
import '../../feature/results/api/results_api_client/results_api_client.dart'
    as _i434;
import '../../feature/results/data/data_sources/results_local_data_source_contract.dart'
    as _i251;
import '../../feature/results/data/data_sources/results_remote_data_source_contract.dart'
    as _i704;
import '../../feature/results/data/repo/results_repo_impl.dart' as _i1016;
import '../../feature/results/domain/repo/results_repo_contract.dart' as _i358;
import '../../feature/results/domain/use_cases/get_saved_exams_use_case.dart'
    as _i987;
import '../../feature/results/domain/use_cases/get_subject_use_case.dart'
    as _i929;
import '../../feature/results/presentation/bloc/results_bloc.dart' as _i1071;
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
    gh.factory<_i637.HiveStorageContract>(() => _i526.HiveStorageImpl());
    gh.factory<_i108.SecureStorage>(
      () => _i108.SecureStorageImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i620.RegisterApiService>(
      () => _i620.RegisterApiService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i461.ExploreService>(
      () => _i461.ExploreService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i225.ChangePasswordService>(
      () => _i225.ChangePasswordService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i434.ResultsApiClient>(
      () => _i434.ResultsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i439.ForgetPasswordApiClient>(
      () => _i439.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i1057.LoginApiClient>(
      () => _i1057.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i922.ExamApiClient>(() => _i922.ExamApiClient(gh<_i361.Dio>()));
    gh.factory<_i199.ExamSubjectApiClient>(
      () => _i199.ExamSubjectApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i365.ProfileApiClient>(
      () => _i365.ProfileApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i51.LoginLocalDataSource>(
      () => _i51.LoginLocalDataSourceImpl(gh<_i108.SecureStorage>()),
    );
    gh.factory<_i643.ChangePasswordRemoteDataSource>(
      () => _i416.ChangePasswordRemoteDataSourceImpl(
        gh<_i225.ChangePasswordService>(),
      ),
    );
    gh.factory<_i407.ExploreRemoteDatasource>(
      () => _i508.ExploreRemoteDataSourceImpl(gh<_i461.ExploreService>()),
    );
    gh.factory<_i32.ForgetPasswordRemoteDataSourcesContract>(
      () => _i913.ForgetPasswordRemoteDataSourcesImpl(
        gh<_i439.ForgetPasswordApiClient>(),
      ),
    );
    gh.factory<_i38.ChangePasswordRepo>(
      () => _i942.ChangePasswordRepoImpl(
        gh<_i643.ChangePasswordRemoteDataSource>(),
        gh<_i108.SecureStorage>(),
      ),
    );
    gh.factory<_i907.ForgetPasswordRepoContract>(
      () => _i710.ForgetPasswordRepoImpl(
        gh<_i32.ForgetPasswordRemoteDataSourcesContract>(),
      ),
    );
    gh.factory<_i679.ExploreRepo>(
      () => _i495.ExploreRepoImp(
        gh<_i407.ExploreRemoteDatasource>(),
        gh<_i108.SecureStorage>(),
      ),
    );
    gh.factory<_i1012.ExamLocalDataSourceContract>(
      () => _i840.ExamLocalDataSourceImpl(gh<_i637.HiveStorageContract>()),
    );
    gh.factory<_i251.ResultsLocalDataSourceContract>(
      () => _i803.ResultsLocalDataSourceImpl(gh<_i637.HiveStorageContract>()),
    );
    gh.factory<_i208.ProfileRemoteDataSourceContract>(
      () => _i711.ProfileRemoteDataSourceImpl(
        gh<_i365.ProfileApiClient>(),
        gh<_i108.SecureStorage>(),
      ),
    );
    gh.factory<_i704.ResultsRemoteDataSourceContract>(
      () => _i649.ResultsRemoteDataSourceImpl(
        gh<_i434.ResultsApiClient>(),
        gh<_i108.SecureStorage>(),
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
    gh.factory<_i188.ExamSubjectRemoteDataSourcesContract>(
      () => _i869.ExamSubjectRemoteDataSourcesImpl(
        gh<_i199.ExamSubjectApiClient>(),
      ),
    );
    gh.factory<_i334.ProfileRepoContract>(
      () => _i341.ProfileRepoImpl(gh<_i208.ProfileRemoteDataSourceContract>()),
    );
    gh.factory<_i191.ExamRemoteDataSourceContract>(
      () => _i589.ExamRemoteDataSourceImpl(
        gh<_i922.ExamApiClient>(),
        gh<_i108.SecureStorage>(),
      ),
    );
    gh.factory<_i777.ForgetPasswordCubit>(
      () => _i777.ForgetPasswordCubit(gh<_i944.ForgetPasswordUseCase>()),
    );
    gh.factory<_i700.VerificationCubit>(
      () => _i700.VerificationCubit(gh<_i511.VerifyResetCodeUseCase>()),
    );
    gh.factory<_i281.SubjectsUseCase>(
      () => _i281.SubjectsUseCase(gh<_i679.ExploreRepo>()),
    );
    gh.factory<_i58.LoginUseCase>(
      () => _i58.LoginUseCase(gh<_i914.LoginRepository>()),
    );
    gh.factory<_i1010.ExamSubjectRepoContract>(
      () => _i919.ExamSubjectRepoImpl(
        gh<_i188.ExamSubjectRemoteDataSourcesContract>(),
      ),
    );
    gh.factory<_i1018.LoginBloc>(
      () => _i1018.LoginBloc(gh<_i58.LoginUseCase>()),
    );
    gh.factory<_i529.ChangePasswordUseCase>(
      () => _i529.ChangePasswordUseCase(gh<_i38.ChangePasswordRepo>()),
    );
    gh.factory<_i628.RegisterRepoContract>(
      () => _i820.RegisterRepoImpl(
        gh<_i755.RegisterRemoteDatasourceContract>(),
        gh<_i51.LoginLocalDataSource>(),
      ),
    );
    gh.factory<_i757.ChangePasswordCubit>(
      () => _i757.ChangePasswordCubit(gh<_i529.ChangePasswordUseCase>()),
    );
    gh.factory<_i358.ResultsRepoContract>(
      () => _i1016.ResultsRepoImpl(
        gh<_i251.ResultsLocalDataSourceContract>(),
        gh<_i704.ResultsRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i696.ExploreCubit>(
      () => _i696.ExploreCubit(gh<_i281.SubjectsUseCase>()),
    );
    gh.factory<_i36.EditProfileUseCase>(
      () => _i36.EditProfileUseCase(gh<_i334.ProfileRepoContract>()),
    );
    gh.factory<_i736.GetUserProfileUseCase>(
      () => _i736.GetUserProfileUseCase(gh<_i334.ProfileRepoContract>()),
    );
    gh.factory<_i1036.ResetPasswordCubit>(
      () => _i1036.ResetPasswordCubit(gh<_i756.ResetPasswordUseCase>()),
    );
    gh.factory<_i345.ExamRepoContract>(
      () => _i94.ExamRepoImpl(
        gh<_i191.ExamRemoteDataSourceContract>(),
        gh<_i1012.ExamLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i930.ExamSubjectUseCase>(
      () => _i930.ExamSubjectUseCase(gh<_i1010.ExamSubjectRepoContract>()),
    );
    gh.factory<_i987.GetSavedExamsUseCase>(
      () => _i987.GetSavedExamsUseCase(gh<_i358.ResultsRepoContract>()),
    );
    gh.factory<_i929.GetSubjectUseCase>(
      () => _i929.GetSubjectUseCase(gh<_i358.ResultsRepoContract>()),
    );
    gh.factory<_i43.GetExamQuestionsUseCase>(
      () => _i43.GetExamQuestionsUseCase(gh<_i345.ExamRepoContract>()),
    );
    gh.factory<_i307.StoreExamResultUseCase>(
      () => _i307.StoreExamResultUseCase(gh<_i345.ExamRepoContract>()),
    );
    gh.factory<_i198.RegisterUseCase>(
      () => _i198.RegisterUseCase(gh<_i628.RegisterRepoContract>()),
    );
    gh.factory<_i784.ProfileCubit>(
      () => _i784.ProfileCubit(
        gh<_i736.GetUserProfileUseCase>(),
        gh<_i36.EditProfileUseCase>(),
      ),
    );
    gh.factory<_i870.ExamSubjectCubit>(
      () => _i870.ExamSubjectCubit(gh<_i930.ExamSubjectUseCase>()),
    );
    gh.factory<_i1071.ResultsBloc>(
      () => _i1071.ResultsBloc(gh<_i987.GetSavedExamsUseCase>()),
    );
    gh.factory<_i583.RegisterCubit>(
      () => _i583.RegisterCubit(gh<_i198.RegisterUseCase>()),
    );
    gh.factory<_i635.ExamBloc>(
      () => _i635.ExamBloc(
        gh<_i43.GetExamQuestionsUseCase>(),
        gh<_i307.StoreExamResultUseCase>(),
      ),
    );
    return this;
  }
}

class _$StorageModule extends _i371.StorageModule {}

class _$DioModule extends _i977.DioModule {}
