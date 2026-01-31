import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/signup_repository.dart';

class ManualSignupParams extends Equatable {
  final String fullName;
  final String username;
  final DateTime dateOfBirth;
  final String gender;
  final String instagramUsername;
  final String youtubeUsername;

  const ManualSignupParams({
    required this.fullName,
    required this.username,
    required this.dateOfBirth,
    required this.gender,
    required this.instagramUsername,
    required this.youtubeUsername,
  });

  @override
  List<Object?> get props => [
    fullName,
    username,
    dateOfBirth,
    gender,
    instagramUsername,
    youtubeUsername,
  ];
}

class ManualSignupUseCase implements UseCase<UserEntity, ManualSignupParams> {
  final SignupRepository repository;

  ManualSignupUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(ManualSignupParams params) async {
    return await repository.signupManually(
      fullName: params.fullName,
      username: params.username,
      dateOfBirth: params.dateOfBirth,
      gender: params.gender,
      instagramUsername: params.instagramUsername,
      youtubeUsername: params.youtubeUsername,
    );
  }
}
