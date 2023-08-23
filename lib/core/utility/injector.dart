import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:dermo/logic/data_objects/entities/common/entity_factory.dart';

import 'package:dermo/logic/data_sources/remote/auth_data_source.dart';
import 'package:dermo/logic/data_sources/remote/db_data_source.dart';

import 'package:dermo/logic/managers/user_manager.dart';

import 'package:dermo/logic/use_cases/sign_in_use_case.dart';
import 'package:dermo/logic/use_cases/sign_out_use_case.dart';
import 'package:dermo/logic/use_cases/sign_up_use_case.dart';

final injector = GetIt.I;

Future<void> initializeDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  injector.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  injector.registerLazySingleton<EntityFactory>(() => EntityFactory());

  injector.registerLazySingleton<AuthDataSource>(() => AuthDataSource());

  injector.registerLazySingleton<DbDataSource>(() => DbDataSource(entityFactory: injector()));

  injector.registerLazySingleton<UserManager>(
      () => UserManager(authDataSource: injector(), dbDataSource: injector()));

  injector.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(userManager: injector()));

  injector.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(userManager: injector()));

  injector.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(userManager: injector()));

  // injector.registerLazySingleton<FireStorePostRepository>(
  //       () => FireStorePostRepositoryImpl(),
  // );
}
