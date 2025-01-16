import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/detail_event_response.dart';
import '../../../data/event_response.dart';
import '../../../utils/api.dart';
import '../views/index_view.dart';
import '../views/profile_view.dart';
import '../views/your_event_view.dart';

class DashboardController extends GetxController {
  final _getConnect = GetConnect();
  var selectedIndex = 0.obs;

  final token = GetStorage().read('token');

  // Deklarasikan TextEditingController di sini agar dapat digunakan secara global dalam controller
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // Mengambil event
  Future<EventResponse> getEvent() async {
    final response = await _getConnect.get(
      BaseUrl.events,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    return EventResponse.fromJson(response.body);
  }

  var yourEvents = <Events>[].obs;

  // Mengambil event milik pengguna
  Future<void> getYourEvent() async {
    final response = await _getConnect.get(
      BaseUrl.yourEvent,
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    final eventResponse = EventResponse.fromJson(response.body);
    yourEvents.value = eventResponse.events ?? [];
  }

  // Fungsi untuk mengambil detail event berdasarkan ID
  Future<DetailEventResponse> getDetailEvent({required int id}) async {
    final response = await _getConnect.get(
      '${BaseUrl.detailEvents}/$id', // URL endpoint untuk mengambil detail event
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );
    return DetailEventResponse.fromJson(response.body);
  }

  // Menambah event
  void addEvent() async {
    final response = await _getConnect.post(
      BaseUrl.events, 
      {
        'name': nameController.text, 
        'description': descriptionController.text, 
        'event_date': eventDateController.text, 
        'location': locationController.text,
      },
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );

    if (response.statusCode == 201) {
      // Notifikasi dan reset form setelah sukses
      Get.snackbar(
        'Success',
        'Event Added',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      nameController.clear();
      descriptionController.clear();
      eventDateController.clear();
      locationController.clear();
      update();
      getEvent();
      getYourEvent();
      Get.close(1); // Tutup halaman atau modal
    } else {
      // Notifikasi jika gagal
      Get.snackbar(
        'Failed',
        'Event Failed to Add',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Mengedit event
  void editEvent({required int id}) async {
    final response = await _getConnect.post(
      '${BaseUrl.events}/$id',
      {
        'name': nameController.text,
        'description': descriptionController.text,
        'event_date': eventDateController.text,
        'location': locationController.text,
        '_method': 'PUT', // Hack method jadi PUT untuk update
      },
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );

    if (response.statusCode == 200) {
      // Notifikasi jika sukses
      Get.snackbar(
        'Success',
        'Event Updated',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      nameController.clear();
      descriptionController.clear();
      eventDateController.clear();
      locationController.clear();
      update();
      getEvent();
      getYourEvent();
      Get.close(1); // Tutup halaman edit
    } else {
      // Notifikasi jika gagal
      Get.snackbar(
        'Failed',
        'Event Failed to Update',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Menghapus event
  void deleteEvent({required int id}) async {
    final response = await _getConnect.post(
      '${BaseUrl.deleteEvents}$id',
      {
        '_method': 'delete', // Hack DELETE request
      },
      headers: {'Authorization': "Bearer $token"},
      contentType: "application/json",
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Event Deleted',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      update();
      getEvent();
      getYourEvent();
    } else {
      Get.snackbar(
        'Failed',
        'Event Failed to Delete',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Fungsi untuk mengubah halaman yang ditampilkan
  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    IndexView(),
    YourEventView(),
    ProfileView(),
  ];

  // Inisialisasi data ketika controller dimulai
  @override
  void onInit() {
    getEvent();
    getYourEvent();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    eventDateController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
