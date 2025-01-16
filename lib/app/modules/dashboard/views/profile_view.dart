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
      ),
      body: Obx(() {
        final profile = controller.profileResponse.value;

        if (profile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center( // Wrap the entire content with a Center widget
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensures the Column takes up only necessary space
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profile.avatar != null
                      ? NetworkImage(profile.avatar!) as ImageProvider
                      : const AssetImage('assets/images/default_avatar.png'),
                ),
                const SizedBox(height: 16),
                // Nama
                Text(
                  profile.name ?? 'Nama tidak ditemukan',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // Email
                Text(
                  profile.email ?? 'Email tidak ditemukan',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                // Logout button
                ElevatedButton(
                  onPressed: () => controller.logOut(),
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
