import 'package:equatable/equatable.dart';

enum SignupType { google, manual }

class UserEntity extends Equatable {
  final SignupType signupType;
  final String fullName;
  final String? email; // Google only
  final String? username; // Manual only
  final DateTime? dateOfBirth; // Manual only
  final String? gender; // Manual only
  final String? instagramUsername; // Manual only
  final String? youtubeUsername; // Manual only
  final String? profilePhotoUrl; // Optional for both

  const UserEntity({
    required this.signupType,
    required this.fullName,
    this.email,
    this.username,
    this.dateOfBirth,
    this.gender,
    this.instagramUsername,
    this.youtubeUsername,
    this.profilePhotoUrl,
  });

  @override
  List<Object?> get props => [
    signupType,
    fullName,
    email,
    username,
    dateOfBirth,
    gender,
    instagramUsername,
    youtubeUsername,
    profilePhotoUrl,
  ];
}
