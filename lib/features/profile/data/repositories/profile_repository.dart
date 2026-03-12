import 'package:first_proj/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  /// Mendapatkan profil user
  Future<ProfileModel> getUserProfile() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy profil
    return ProfileModel(
      name: 'Admin DATT',
      role: 'Administrator',
      email: 'admin.datt@example.com',
      phone: '+62 812-3456-7890',
      address: 'Jalan Raya No. 123, Kota Indonesia',
      photoUrl: 'https://via.placeholder.com/150',
      additionalInfo: {
        'department': 'Information Technology',
        'joinDate': '2020-01-15',
        'status': 'Active',
      },
    );
  }

  /// Update profil user
  Future<bool> updateUserProfile(ProfileModel profile) async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Return true jika update berhasil
    return true;
  }
}
