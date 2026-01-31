import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/signup_repository.dart';

class GoogleSignupUseCase implements UseCase<UserEntity, NoParams> {
  final SignupRepository repository;

  GoogleSignupUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.signupWithGoogle();
  }
}
