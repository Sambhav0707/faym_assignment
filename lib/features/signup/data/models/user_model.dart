import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.signupType,
    required super.fullName,
    super.email,
    super.username,
    super.dateOfBirth,
    super.gender,
    super.instagramUsername,
    super.youtubeUsername,
    super.profilePhotoUrl,
  });

  factory UserModel.fromGoogleAccount(GoogleSignInAccount account) {
    return UserModel(
      signupType: SignupType.google,
      fullName: account.displayName ?? 'No Name',
      email: account.email,
      profilePhotoUrl: account.photoUrl,
    );
  }

  factory UserModel.fromManualInput({
    required String fullName,
    required String username,
    required DateTime dateOfBirth,
    required String gender,
    required String instagramUsername,
    required String youtubeUsername,
  }) {
    return UserModel(
      signupType: SignupType.manual,
      fullName: fullName,
      username: username,
      dateOfBirth: dateOfBirth,
      gender: gender,
      instagramUsername: instagramUsername,
      youtubeUsername: youtubeUsername,
    );
  }
}
