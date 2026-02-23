import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/profile_controller.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for all profile fields
  final _nameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // Image handling
  File? _selectedImage;
  Uint8List? _imageBytes; // for web
  String? _profileImageUrl;
  final ImagePicker _picker = ImagePicker();

  // Track if profile data has been loaded to avoid infinite loops
  bool _isProfileLoaded = false;

  @override
  void initState() {
    super.initState();
    // Load profile data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileControllerProvider.notifier).loadProfile();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyNameController.dispose();
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          setState(() {
            _imageBytes = bytes;
            _selectedImage = null;
          });
        } else {
          setState(() {
            _selectedImage = File(image.path);
            _imageBytes = null;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _loadProfileData(Map<String, dynamic>? profile) {
    if (profile == null || !mounted) return;

    print('=== _loadProfileData called ===');
    print('Profile data: $profile');

    // Update text controllers with profile data
    _nameController.text = profile['name'] ?? '';
    _companyNameController.text =
        profile['businessName'] ?? profile['companyName'] ?? '';
    _userNameController.text =
        profile['userName'] ?? profile['email']?.split('@')[0] ?? '';
    _emailController.text = profile['email'] ?? '';
    _phoneController.text = profile['phone'] ?? '';

    // Split name into first and last name if available
    final fullName = profile['name'] ?? '';
    final nameParts = fullName.split(' ');
    if (nameParts.isNotEmpty) {
      _firstNameController.text = nameParts.first;
      if (nameParts.length > 1) {
        _lastNameController.text = nameParts.sublist(1).join(' ');
      } else {
        _lastNameController.text = '';
      }
    }

    // Update profile image URL
    _profileImageUrl = profile['profileImage'] ?? profile['imageUrl'];

    // Mark as loaded
    _isProfileLoaded = true;

    // Force rebuild to show the updated data
    if (mounted) {
      setState(() {});
    }

    print('Text controllers updated successfully');
    print('  Name: ${_nameController.text}');
    print('  Email: ${_emailController.text}');
    print('  Phone: ${_phoneController.text}');
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final fullName =
          '${_firstNameController.text} ${_lastNameController.text}'.trim();

      // Prepare profile data
      final profileData = {
        'name': fullName.isNotEmpty ? fullName : _nameController.text,
        'businessName': _companyNameController.text,
        'userName': _userNameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      };

      // Image upload
      // Convert image to base64 if selected
      /*
      if (_selectedImage != null) {
        // Show notification that image upload is not yet supported
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Image upload will be available soon. Saving other profile data...',
              ),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
      */

      final success = await ref
          .read(profileControllerProvider.notifier)
          .updateProfile(profileData, imageFile: _selectedImage);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
          // Clear selected image after successful save
          setState(() {
            _selectedImage = null;
            _imageBytes = null;
            _isProfileLoaded = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                ref.read(profileControllerProvider).errorMessage ??
                    'Failed to update profile',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);

    // Update text controllers when profile data changes
    // Only load once to avoid infinite loops
    if (profileState.profile != null &&
        !profileState.isLoading &&
        !_isProfileLoaded) {
      // Use addPostFrameCallback to avoid calling setState during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadProfileData(profileState.profile);
      });
    }

    print('=== BUILD METHOD ===');
    print('Profile state - isLoading: ${profileState.isLoading}');
    print('Profile state - errorMessage: ${profileState.errorMessage}');
    print('Profile state - profile: ${profileState.profile}');
    print('Profile loaded flag: $_isProfileLoaded');

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Light grey background from UI
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              "User Profile",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(
                            Icons.person_outline,
                            "Basic Information",
                          ),
                          const SizedBox(height: 20),

                          // Image Upload Section
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: _imageBytes != null
                                    ? Image.memory(
                                        _imageBytes!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : _selectedImage != null
                                    ? Image.file(
                                        _selectedImage!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : _profileImageUrl != null
                                    ? Image.network(
                                        _profileImageUrl!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                width: 100,
                                                height: 100,
                                                color: Colors.grey.shade300,
                                                child: const Icon(
                                                  Icons.person,
                                                  size: 50,
                                                  color: Colors.grey,
                                                ),
                                              );
                                            },
                                      )
                                    : Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey.shade300,
                                        child: const Icon(
                                          Icons.person,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: _pickImage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange.shade400,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                      child: const Text("Change Image"),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Upload an image below 2 MB, Accepted File format JPG, PNG",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Responsive Form Layout
                          LayoutBuilder(
                            builder: (context, constraints) {
                              // Use single column if width is less than 600
                              bool useSingleColumn = constraints.maxWidth < 600;

                              return Column(
                                children: [
                                  // Name and Company Name
                                  useSingleColumn
                                      ? Column(
                                          children: [
                                            _buildField(
                                              "Name *",
                                              _nameController,
                                            ),
                                            const SizedBox(height: 20),
                                            _buildField(
                                              "Company Name *",
                                              _companyNameController,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: _buildField(
                                                "Name *",
                                                _nameController,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: _buildField(
                                                "Company Name *",
                                                _companyNameController,
                                              ),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(height: 20),

                                  // First Name and Last Name
                                  useSingleColumn
                                      ? Column(
                                          children: [
                                            _buildField(
                                              "First Name *",
                                              _firstNameController,
                                            ),
                                            const SizedBox(height: 20),
                                            _buildField(
                                              "Last Name *",
                                              _lastNameController,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: _buildField(
                                                "First Name *",
                                                _firstNameController,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: _buildField(
                                                "Last Name *",
                                                _lastNameController,
                                              ),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(height: 20),

                                  // Email and Phone
                                  useSingleColumn
                                      ? Column(
                                          children: [
                                            _buildField(
                                              "Email",
                                              _emailController,
                                              readOnly: true,
                                            ),
                                            const SizedBox(height: 20),
                                            _buildField(
                                              "Phone Number *",
                                              _phoneController,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: _buildField(
                                                "Email",
                                                _emailController,
                                                readOnly: true,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: _buildField(
                                                "Phone Number *",
                                                _phoneController,
                                              ),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(height: 20),

                                  // User Name
                                  useSingleColumn
                                      ? _buildField(
                                          "User Name *",
                                          _userNameController,
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: _buildField(
                                                "User Name *",
                                                _userNameController,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            const Expanded(
                                              child: SizedBox(),
                                            ), // Empty space for layout consistency
                                          ],
                                        ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 32),
                          // Action Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Reset the flag and reload profile data to cancel changes
                                  setState(() {
                                    _isProfileLoaded = false;
                                  });
                                  ref
                                      .read(profileControllerProvider.notifier)
                                      .loadProfile();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                    0xFF0F172A,
                                  ), // Dark Navy
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: const Text("Cancel"),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: _saveProfile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange.shade400,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: const Text("Save Changes"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.orange.shade400),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          readOnly: readOnly,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            filled: readOnly,
            fillColor: readOnly ? Colors.grey.shade100 : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            suffixIcon: isPassword
                ? const Icon(Icons.visibility_off_outlined, size: 20)
                : null,
          ),
        ),
      ],
    );
  }
}
