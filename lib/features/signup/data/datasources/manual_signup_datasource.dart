import '../models/user_model.dart';

abstract class ManualSignupDataSource {
  Future<UserModel> signUp({
    required String fullName,
    required String username,
    required DateTime dateOfBirth,
    required String gender,
    required String instagramUsername,
    required String youtubeUsername,
  });
}

class ManualSignupDataSourceImpl implements ManualSignupDataSource {
  @override
  Future<UserModel> signUp({
    required String fullName,
    required String username,
    required DateTime dateOfBirth,
    required String gender,
    required String instagramUsername,
    required String youtubeUsername,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Simulate success
    return UserModel.fromManualInput(
      fullName: fullName,
      username: username,
      dateOfBirth: dateOfBirth,
      gender: gender,
      instagramUsername: instagramUsername,
      youtubeUsername: youtubeUsername,
    );
  }
}
