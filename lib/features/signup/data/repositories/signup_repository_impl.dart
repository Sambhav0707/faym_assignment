import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/signup_repository.dart';
import '../datasources/google_signup_datasource.dart';
import '../datasources/manual_signup_datasource.dart';

class SignupRepositoryImpl implements SignupRepository {
  final GoogleSignupDataSource googleSignupDataSource;
  final ManualSignupDataSource manualSignupDataSource;

  SignupRepositoryImpl({
    required this.googleSignupDataSource,
    required this.manualSignupDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> signupWithGoogle() async {
    try {
      final user = await googleSignupDataSource.signIn();
      return Right(user);
    } catch (e) {
      if (e.toString().contains('Cancelled')) {
        return Left(AuthFailure(e.toString()));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signupManually({
    required String fullName,
    required String username,
    required DateTime dateOfBirth,
    required String gender,
    required String instagramUsername,
    required String youtubeUsername,
  }) async {
    try {
      final user = await manualSignupDataSource.signUp(
        fullName: fullName,
        username: username,
        dateOfBirth: dateOfBirth,
        gender: gender,
        instagramUsername: instagramUsername,
        youtubeUsername: youtubeUsername,
      );
      return Right(user);
    } catch (e) {
      return Left(ValidationFailure(e.toString()));
    }
  }
}
