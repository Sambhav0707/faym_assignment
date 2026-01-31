import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class SignupRepository {
  Future<Either<Failure, UserEntity>> signupWithGoogle();

  Future<Either<Failure, UserEntity>> signupManually({
    required String fullName,
    required String username,
    required DateTime dateOfBirth,
    required String gender,
    required String instagramUsername,
    required String youtubeUsername,
  });
}
