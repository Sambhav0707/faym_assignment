import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

abstract class GoogleSignupDataSource {
  Future<UserModel> signIn();
}

class GoogleSignupDataSourceImpl implements GoogleSignupDataSource {
  final GoogleSignIn googleSignIn;

  GoogleSignupDataSourceImpl({required this.googleSignIn});

  @override
  Future<UserModel> signIn() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) {
        throw Exception('Google Sign In Cancelled');
      }
      return UserModel.fromGoogleAccount(account);
    } catch (e) {
      throw Exception('Google Sign In Failed: $e');
    }
  }
}
