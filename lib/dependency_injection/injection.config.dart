// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i29;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i11;
import 'package:fresh_dio/fresh_dio.dart' as _i21;
import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql_flutter/graphql_flutter.dart' as _i13;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i14;
import 'package:senpai/core/auth/blocs/create_user_bloc.dart' as _i5;
import 'package:senpai/core/auth/blocs/resend_verification_code_bloc.dart'
    as _i17;
import 'package:senpai/core/auth/blocs/sign_in_bloc.dart' as _i19;
import 'package:senpai/core/auth/blocs/validate_phone_bloc.dart' as _i27;
import 'package:senpai/core/profile_fill/api/universities_api.dart' as _i24;
import 'package:senpai/core/profile_fill/blocs/delete_photo/delete_photo_bloc.dart'
    as _i7;
import 'package:senpai/core/profile_fill/blocs/reorder_photos/reorder_photos_bloc.dart'
    as _i16;
import 'package:senpai/core/profile_fill/blocs/upload_photo/upload_photo_bloc.dart'
    as _i26;
import 'package:senpai/core/profile_fill/favorite_anime/add_favorite_anime_bloc.dart'
    as _i3;
import 'package:senpai/core/profile_fill/favorite_anime/delete_favorite_anime_bloc.dart'
    as _i6;
import 'package:senpai/core/profile_fill/favorite_anime/fetch_anime_bloc.dart'
    as _i9;
import 'package:senpai/core/profile_fill/set_user_location/set_user_location_bloc.dart'
    as _i18;
import 'package:senpai/core/secure_storage/secure_auth_storage.dart' as _i23;
import 'package:senpai/core/user/blocs/fetch_user/fetch_user_bloc.dart' as _i10;
import 'package:senpai/core/user/blocs/update_user/update_user_bloc.dart'
    as _i25;
import 'package:senpai/core/user/blocs/verify_photo_user/verify_photo_user_bloc.dart'
    as _i28;
import 'package:senpai/dependency_injection/dio_client_di.dart' as _i35;
import 'package:senpai/dependency_injection/graphql_client_di.dart' as _i33;
import 'package:senpai/dependency_injection/network_info_di.dart' as _i34;
import 'package:senpai/dependency_injection/router_di.dart' as _i30;
import 'package:senpai/dependency_injection/secure_storage_di.dart' as _i31;
import 'package:senpai/dependency_injection/university_module_di.dart' as _i32;
import 'package:senpai/domain/profile_fill/universities_usecase.dart' as _i12;
import 'package:senpai/models/auth/auth_model.dart' as _i22;
import 'package:senpai/models/env_model.dart' as _i8;
import 'package:senpai/models/theme_model.dart' as _i20;
import 'package:senpai/routes/app_router.dart' as _i4;
import 'package:senpai/utils/helpers/logging_helpers.dart' as _i15;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final routerInjection = _$RouterInjection();
    final secureStorageInjection = _$SecureStorageInjection();
    final universityInjectionModule = _$UniversityInjectionModule();
    final graphQLInjection = _$GraphQLInjection();
    final networkInfoInjection = _$NetworkInfoInjection();
    final dioInjection = _$DioInjection();
    gh.factory<_i3.AddFavoriteAnimeBloc>(() => _i3.AddFavoriteAnimeBloc());
    gh.factory<_i4.AppRouter>(() => routerInjection.router());
    gh.factory<_i5.CreateUserBloc>(() => _i5.CreateUserBloc());
    gh.factory<_i6.DeleteFavoriteAnimeBloc>(
        () => _i6.DeleteFavoriteAnimeBloc());
    gh.factory<_i7.DeletePhotoBloc>(() => _i7.DeletePhotoBloc());
    await gh.singletonAsync<_i8.EnvModel>(
      () => _i8.EnvModel.create(),
      preResolve: true,
    );
    gh.factory<_i9.FetchAnimeBloc>(() => _i9.FetchAnimeBloc());
    gh.factory<_i10.FetchUserBloc>(() => _i10.FetchUserBloc());
    gh.factory<_i11.FlutterSecureStorage>(
        () => secureStorageInjection.storage());
    gh.factory<_i12.GetUniversitiesUseCase>(
        () => universityInjectionModule.universitiesRepository);
    gh.factory<_i13.GraphQLClient>(
        () => graphQLInjection.graphql(gh<_i8.EnvModel>()));
    gh.factory<_i14.InternetConnection>(() => networkInfoInjection.networkInfo);
    gh.singleton<_i15.LoggingHelper>(_i15.LoggingHelper());
    gh.factory<_i16.ReorderPhotosBloc>(() => _i16.ReorderPhotosBloc());
    gh.factory<_i17.ResendVerificationCodeBloc>(
        () => _i17.ResendVerificationCodeBloc());
    gh.factory<_i18.SetUserLocationBloc>(() => _i18.SetUserLocationBloc());
    gh.factory<_i19.SignInBloc>(() => _i19.SignInBloc());
    await gh.singletonAsync<_i20.ThemeModel>(
      () => _i20.ThemeModel.create(),
      preResolve: true,
    );
    gh.lazySingleton<_i21.TokenStorage<_i22.AuthModel>>(
        () => _i23.SecureAuthStorage(gh<_i11.FlutterSecureStorage>()));
    gh.factory<_i24.UniversitiesApi>(
        () => universityInjectionModule.universitiesApi(gh<_i8.EnvModel>()));
    gh.factory<_i25.UpdateUserBloc>(() => _i25.UpdateUserBloc());
    gh.factory<_i26.UploadPhotoBloc>(() => _i26.UploadPhotoBloc());
    gh.factory<_i27.ValidatePhoneBloc>(() => _i27.ValidatePhoneBloc());
    gh.factory<_i28.VerifyPhotoUserBloc>(() => _i28.VerifyPhotoUserBloc());
    gh.factory<_i29.Dio>(() => dioInjection.dio(gh<_i8.EnvModel>()));
    return this;
  }
}

class _$RouterInjection extends _i30.RouterInjection {}

class _$SecureStorageInjection extends _i31.SecureStorageInjection {}

class _$UniversityInjectionModule extends _i32.UniversityInjectionModule {}

class _$GraphQLInjection extends _i33.GraphQLInjection {}

class _$NetworkInfoInjection extends _i34.NetworkInfoInjection {}

class _$DioInjection extends _i35.DioInjection {}
