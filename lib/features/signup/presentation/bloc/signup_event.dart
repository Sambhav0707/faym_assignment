part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignupWithGoogleRequested extends SignupEvent {
  const SignupWithGoogleRequested();
}

class SignupManuallyRequested extends SignupEvent {
  final String fullName;
  final String username;
  final DateTime dateOfBirth;
  final String gender;
  final String instagramUsername;
  final String youtubeUsername;

  const SignupManuallyRequested({
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
