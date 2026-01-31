import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../features/signup/data/datasources/google_signup_datasource.dart';
import '../../features/signup/data/datasources/manual_signup_datasource.dart';
import '../../features/signup/data/repositories/signup_repository_impl.dart';
import '../../features/signup/domain/repositories/signup_repository.dart';
import '../../features/signup/domain/usecases/google_signup_usecase.dart';
import '../../features/signup/domain/usecases/manual_signup_usecase.dart';
import '../../features/signup/presentation/bloc/signup_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Signup

  // BLoC
  sl.registerFactory(
    () => SignupBloc(googleSignupUseCase: sl(), manualSignupUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GoogleSignupUseCase(sl()));
  sl.registerLazySingleton(() => ManualSignupUseCase(sl()));

  // Repository
  sl.registerLazySingleton<SignupRepository>(
    () => SignupRepositoryImpl(
      googleSignupDataSource: sl(),
      manualSignupDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<GoogleSignupDataSource>(
    () => GoogleSignupDataSourceImpl(googleSignIn: sl()),
  );
  sl.registerLazySingleton<ManualSignupDataSource>(
    () => ManualSignupDataSourceImpl(),
  );

  // External
  sl.registerLazySingleton(() => GoogleSignIn());
}
