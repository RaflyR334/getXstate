import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    return Obx(
      () => Scaffold(
        body: Navigator(
          key: Get.nestedKey(1),
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (_) => controller.pages[controller.selectedIndex.value],
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
            Get.nestedKey(1)!.currentState!.pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => controller.pages[index],
                  ),
                );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Index',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Your Event',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
