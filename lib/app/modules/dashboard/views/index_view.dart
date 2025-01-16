import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


import '../../../data/event_response.dart';
import '../controllers/dashboard_controller.dart';
import 'event_detail_view.dart';

class IndexView extends GetView {
  const IndexView({super.key});
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Memberi padding di sekitar konten
        child: FutureBuilder<EventResponse>(
          // Mengambil data event melalui fungsi getEvent dari controller
          future: controller.getEvent(),
          builder: (context, snapshot) {
            // Jika data sedang dimuat, tampilkan animasi loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.network(
                  // Menggunakan animasi Lottie untuk tampilan loading
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true, // Animasi akan berulang terus-menerus
                  width: MediaQuery.of(context).size.width /
                      1, // Menyesuaikan lebar animasi
                ),
              );
            }
            // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
            if (snapshot.data!.events!.isEmpty) {
              return const Center(child: Text("Tidak ada data"));
            }

            return ListView.builder(
              // Menentukan jumlah item berdasarkan panjang data events
              itemCount: snapshot.data!.events!.length,
              controller:
                  scrollController, // Menggunakan ScrollController untuk ListView
              shrinkWrap:
                  true, // Membatasi ukuran ListView agar sesuai dengan konten
              itemBuilder: (context, index) {
                final event = snapshot.data!.events![index];
                return ZoomTapAnimation(
                  onTap: () {
                    // Navigasi ke EventDetailView saat item ditekan
                    Get.to(
                      () => EventDetailView(
                          eventId: snapshot.data!.events![index].id!),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Menyusun elemen secara horizontal di kiri
                    children: [
                      // Menampilkan gambar event
                      Image.network(
                        'https://picsum.photos/id/${snapshot.data!.events![index].id}/700/300',
                        fit: BoxFit
                            .cover, // Menyesuaikan gambar dengan area tampilan
                        height: 200,
                        width: 500,
                        errorBuilder: (context, error, stackTrace) {
                          // Menangani error jika gambar tidak ditemukan
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Image not found'),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16), // Jarak antara elemen
                      // Menampilkan judul event
                      Text(
                        event.name.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold, // Membuat teks menjadi tebal
                        ),
                      ),
                      const SizedBox(height: 8), // Jarak antara elemen
                      // Menampilkan deskripsi event
                      Text(
                        event.description.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey, // Warna teks abu-abu
                        ),
                      ),
                      const SizedBox(height: 16), // Jarak antara elemen
                      Row(
                        children: [
                          // Ikon lokasi
                          const Icon(
                            Icons.location_on,
                            color: Colors.red, // Warna ikon merah
                          ),
                          const SizedBox(
                              width: 8), // Jarak antara ikon dan teks
                          Expanded(
                            child: Text(
                              event.location
                                  .toString(), // Lokasi event
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black, // Warna teks hitam
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Garis pembatas antara item
                      Divider(
                        height: 10, // Tinggi divider
                      ),
                      SizedBox(height: 16), // Jarak setelah divider
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}