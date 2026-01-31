import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'signup_selection_page.dart';
import '../../../../core/di/injection_container.dart';

class UserDetailsPage extends StatelessWidget {
  final UserEntity user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Prevent back button if not needed
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.blueGrey),
            onPressed: () => _handleLogout(context),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            children: [
              // 1. Success Header
              const Icon(Icons.check_circle, color: Colors.green, size: 64),
              const SizedBox(height: 16),
              const Text(
                'Account Created Successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Here’s a summary of your profile information.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 32),

              // 2. Profile Summary Card
              _buildProfileCard(),
              const SizedBox(height: 24),

              // 3. Information Sections
              _buildBasicInfoSection(),

              if (user.signupType == SignupType.manual) ...[
                const SizedBox(height: 24),
                _buildPersonalDetailsSection(),
                const SizedBox(height: 24),
                _buildSocialPresenceSection(),
              ],

              const SizedBox(height: 40),

              // 4. Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {}, // Action to go home
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            backgroundImage: user.profilePhotoUrl != null
                ? NetworkImage(user.profilePhotoUrl!)
                : null,
            child: user.profilePhotoUrl == null
                ? Text(
                    user.fullName.isNotEmpty
                        ? user.fullName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            user.fullName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: user.signupType == SignupType.google
                  ? Colors.red.withOpacity(0.1)
                  : Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              user.signupType == SignupType.google
                  ? 'Signed up with Google'
                  : 'Manual Signup',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: user.signupType == SignupType.google
                    ? Colors.red
                    : Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildInfoCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.grey[700]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      children: [
        _buildSectionTitle('Basic Information'),
        _buildInfoCard(
          children: [
            if (user.email != null) ...[
              _buildInfoRow(Icons.email_outlined, 'Email', user.email!),
            ],
            if (user.username != null) ...[
              _buildInfoRow(Icons.alternate_email, 'Username', user.username!),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildPersonalDetailsSection() {
    return Column(
      children: [
        _buildSectionTitle('Personal Details'),
        _buildInfoCard(
          children: [
            _buildInfoRow(
              Icons.cake_outlined,
              'Date of Birth',
              user.dateOfBirth != null
                  ? user.dateOfBirth!.toLocal().toString().split(' ')[0]
                  : 'N/A',
            ),
            const Divider(height: 24, thickness: 0.5),
            _buildInfoRow(Icons.person_outline, 'Gender', user.gender ?? 'N/A'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialPresenceSection() {
    return Column(
      children: [
        _buildSectionTitle('Social Presence'),
        _buildInfoCard(
          children: [
            _buildInfoRow(
              Icons.camera_alt_outlined,
              'Instagram',
              user.instagramUsername ?? 'N/A',
            ),
            const Divider(height: 24, thickness: 0.5),
            _buildInfoRow(
              Icons.play_circle_outline,
              'YouTube',
              user.youtubeUsername ?? 'N/A',
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    // 1. If Google Signup, sign out from Google
    if (user.signupType == SignupType.google) {
      try {
        await sl<GoogleSignIn>().signOut();
      } catch (e) {
        debugPrint('Logout error: $e');
      }
    }

    // 2. Navigate back to SignupSelectionPage and clear stack
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const SignupSelectionPage()),
        (route) => false,
      );
    }
  }
}
