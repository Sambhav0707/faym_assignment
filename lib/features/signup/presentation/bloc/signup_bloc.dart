import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/google_signup_usecase.dart';
import '../../domain/usecases/manual_signup_usecase.dart';
import '../../../../core/usecases/usecase.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final GoogleSignupUseCase googleSignupUseCase;
  final ManualSignupUseCase manualSignupUseCase;

  SignupBloc({
    required this.googleSignupUseCase,
    required this.manualSignupUseCase,
  }) : super(const SignupInitial()) {
    on<SignupWithGoogleRequested>(_onGoogleSignupRequested);
    on<SignupManuallyRequested>(_onManualSignupRequested);
  }

  Future<void> _onGoogleSignupRequested(
    SignupWithGoogleRequested event,
    Emitter<SignupState> emit,
  ) async {
    emit(const SignupLoading());
    final result = await googleSignupUseCase(const NoParams());
    result.fold(
      (failure) => emit(SignupFailure(failure.message)),
      (user) => emit(SignupSuccess(user)),
    );
  }

  Future<void> _onManualSignupRequested(
    SignupManuallyRequested event,
    Emitter<SignupState> emit,
  ) async {
    emit(const SignupLoading());
    final result = await manualSignupUseCase(
      ManualSignupParams(
        fullName: event.fullName,
        username: event.username,
        dateOfBirth: event.dateOfBirth,
        gender: event.gender,
        instagramUsername: event.instagramUsername,
        youtubeUsername: event.youtubeUsername,
      ),
    );
    result.fold(
      (failure) => emit(SignupFailure(failure.message)),
      (user) => emit(SignupSuccess(user)),
    );
  }
}
