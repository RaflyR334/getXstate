import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import 'add_view.dart';
import 'edit_view.dart';

class YourEventView extends GetView {
  const YourEventView({super.key});
  @override
   Widget build(BuildContext context) {
  // Mendapatkan instance dari DashboardController menggunakan GetX
  DashboardController controller = Get.put(DashboardController());

  // Membuat instance dari ScrollController untuk kontrol scroll pada ListView
  final ScrollController scrollController = ScrollController();

  return Scaffold(
    // Tombol FloatingActionButton untuk menambahkan event baru
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Navigasi ke halaman AddView dan memanggil controller.getYourEvent() setelah kembali
        Get.to(() => AddView())?.then((_) {
          controller.getYourEvent(); // Memanggil ulang data setelah menambahkan event
        });
      },
      child: const Icon(Icons.add), // Menampilkan ikon add
    ),
    appBar: AppBar(
      title: const Text('Your Event'), // Judul aplikasi
      centerTitle: true, // Menyusun judul di tengah
    ),
    body: Padding(
      // Memberikan padding di seluruh body
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        // Menggunakan Obx untuk mendengarkan perubahan pada yourEvents
        if (controller.yourEvents.isEmpty) {
          // Jika tidak ada event, tampilkan pesan bahwa data kosong
          return const Center(child: Text("Tidak ada data"));
        }
        return ListView.builder(
          itemCount: controller.yourEvents.length, // Menentukan jumlah item pada ListView
          controller: scrollController, // Menggunakan controller untuk scroll
          shrinkWrap: true, // Menyesuaikan ukuran ListView dengan konten
          itemBuilder: (context, index) {
            // Mengambil event berdasarkan index
            final event = controller.yourEvents[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Menyusun elemen-elemen secara vertikal
              children: [
                // Menampilkan gambar event
                Image.network(
                  'https://picsum.photos/id/${event.id}/700/300', // URL gambar berdasarkan ID event
                  fit: BoxFit.cover, // Menyesuaikan gambar agar memenuhi area
                  height: 200, // Mengatur tinggi gambar
                  width: 500, // Mengatur lebar gambar
                  errorBuilder: (context, error, stackTrace) {
                    // Jika gambar gagal dimuat, tampilkan pesan error
                    return const SizedBox(
                      height: 200,
                      child: Center(child: Text('Image not found')), // Tampilkan teks "Image not found"
                    );
                  },
                ),
                const SizedBox(height: 16), // Memberikan jarak antar elemen
                Text(
                  event.name!, // Menampilkan nama event
                  style: const TextStyle(
                    fontSize: 24, // Ukuran font untuk nama event
                    fontWeight: FontWeight.bold, // Membuat nama event menjadi tebal
                  ),
                ),
                const SizedBox(height: 8), // Memberikan jarak antara teks nama dan deskripsi
                Text(
                  event.description!, // Menampilkan deskripsi event
                  style: const TextStyle(
                    fontSize: 16, // Ukuran font untuk deskripsi
                    color: Colors.grey, // Warna teks deskripsi
                  ),
                ),
                const SizedBox(height: 16), // Memberikan jarak setelah deskripsi
                Row(
                  // Menampilkan lokasi event di dalam row
                  children: [
                    const Icon(
                      Icons.location_on, // Ikon lokasi
                      color: Colors.red, // Warna ikon lokasi
                    ),
                    const SizedBox(width: 8), // Memberikan jarak antara ikon dan teks
                    Expanded(
                      // Membuat teks lokasi mengisi ruang yang tersedia
                      child: Text(
                        event.location!, // Menampilkan lokasi event
                        style: const TextStyle(
                          fontSize: 16, // Ukuran font untuk lokasi
                          color: Colors.black, // Warna teks lokasi
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 10), // Membuat garis pemisah antar event
                const SizedBox(height: 16),
                Row(
  mainAxisAlignment: MainAxisAlignment.end, // Posisi item di ujung kanan
  children: [
    // Tombol Edit buat ngedit event
    TextButton.icon(
      icon: const Icon(Icons.edit, color: Colors.blue), // Ikon edit dengan warna biru
      label: const Text('Edit', style: TextStyle(color: Colors.blue)), // Teks "Edit" warna biru
      onPressed: () {
        // Aksi kalau tombol Edit diklik
        Get.to(
          () => EditView(
            id: event.id!, // Bawa ID event ke halaman Edit
            title: event.name!, // Bawa nama event ke halaman Edit
          ),
        );
      },
    ),
    // Tombol Delete buat hapus event
    TextButton.icon(
      icon: const Icon(Icons.delete, color: Colors.red), // Ikon delete dengan warna merah
      label: const Text('Delete', style: TextStyle(color: Colors.red)), // Teks "Delete" warna merah
      onPressed: () {
        controller.deleteEvent(id: event.id!);
      },
    ),
  ],
), // Memberikan jarak setelah garis pemisah
              ],
            );
          },
        );
      }),
    ),
  );
}
}
