import 'dart:io';

abstract class ProfileRepository {
  Future<Map<String, dynamic>> getProfile();

  Future<void> updateProfile(Map<String, dynamic> data, {File? imageFile});
}
