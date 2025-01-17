import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class ProfileView extends GetView<DashboardController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.teal, // Change the app bar color to teal for a fresh look
        elevation: 4,
      ),
      body: Obx(() {
        final profile = controller.profileResponse.value;

        if (profile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView( // Add scrolling for better layout on smaller screens
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Align items to the center
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar with shadow and border
                  CircleAvatar(
                    radius: 65,
                    backgroundImage: profile.avatar != null
                        ? NetworkImage(profile.avatar!) as ImageProvider
                        : const AssetImage('assets/images/default_avatar.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 16),
                  // Name with enhanced text style
                  Text(
                    profile.name ?? 'Nama tidak ditemukan',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Email with lighter styling
                  Text(
                    profile.email ?? 'Email tidak ditemukan',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // Logout button with rounded corners and shadow
                  ElevatedButton(
                    onPressed: () => controller.logOut(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Button color matches app bar
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Rounded corners for the button
                      ),
                      elevation: 5, // Button shadow for depth
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
