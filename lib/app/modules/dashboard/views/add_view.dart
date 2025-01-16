import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../controllers/dashboard_controller.dart';

class AddView extends GetView {
  const AddView({super.key});
  @override
  Widget build(BuildContext context) {
    // Nih, bikin controller buat ngurusin dashboard pake Get.put
    DashboardController controller = Get.put(DashboardController());
    return Scaffold(
      // AppBar nih, buat header atas. Judulnya "Add Your Event", terus ada di tengah biar estetik
      appBar: AppBar(
        title: const Text('Add Your Event'), // Judul biar kelihatan niat
        centerTitle: true, // Tengahin judul, biar vibes-nya enak
        backgroundColor: HexColor('#feeee8'), // Warna pastel biar soft
      ),
      // Latar belakang layar, warnanya pastel juga. Matching dong!
      backgroundColor: HexColor('#feeee8'),
      // Badan utama layar, isinya susunan widget
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Animasi Lottie yang lucu biar halaman nggak boring
            Padding(
              padding: const EdgeInsets.only(top: 70.0), // Kasih jarak atas biar napas
              child: Lottie.network(
                'https://gist.githubusercontent.com/olipiskandar/2095343e6b34255dcfb042166c4a3283/raw/d76e1121a2124640481edcf6e7712130304d6236/praujikom_kucing.json',
                fit: BoxFit.cover, // Animasinya dibikin pas di layar
              ),
            ),
            // Input buat nama event. Jangan typo ya!
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15), // Jarak kanan-kiri, biar nggak mepet
              child: TextField(
                controller: controller.nameController, // Controller buat ngontrol input
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Biar ada border, simple tapi classy
                  labelText: 'Event Name', // Labelnya "Event Name", jelas kan?
                  hintText: 'Masukan Nama Event', // Bocoran teks kalau kosong
                ),
              ),
            ),
            // Input buat deskripsi event. Jelasin event kamu di sini
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15), // Kasih ruang napas
              child: TextField(
                controller: controller.descriptionController, // Controller buat deskripsi
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Border kotak, biar rapih
                  labelText: 'Description', // Labelnya deskripsi, apa lagi coba?
                  hintText: 'Masukan Deskripsi', // Buat clue aja
                ),
              ),
            ),
            // Input tanggal event. Tinggal klik terus pilih tanggal, gampang banget
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15), // Kasih jarak kanan-kiri
              child: TextField(
                controller: controller.eventDateController, // Controller tanggal
                readOnly: true, // Teks nggak bisa diubah langsung, harus lewat picker
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Biar kelihatan kotak rapi
                  labelText: 'Event Date', // Labelnya tanggal
                  hintText: 'Masukan Tanggal Event', // Kasih tau buat apa
                ),
                onTap: () async {
                  // Nih, kalau ditekan bakal keluar kalender
                  DateTime? selectedDate = await showDatePicker(
                    context: context, // Butuh context buat munculin
                    initialDate: DateTime.now(), // Mulainya dari tanggal sekarang
                    firstDate: DateTime(2024), // Minimal pilih tahun 2024
                    lastDate: DateTime(2100), // Maksimal sampai tahun 2100. Wkwk lama amat!
                  );
                  // Kalau tanggalnya kepilih, langsung di-update
                  if (selectedDate != null) {
                    controller.eventDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                  }
                },
              ),
            ),
            // Input buat lokasi. Eventnya di mana nih?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15), // Jarak biar lega
              child: TextField(
                controller: controller.locationController, // Controller lokasi
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Border biar kotak
                  labelText: 'Location', // Labelnya lokasi, jelas banget
                  hintText: 'Masukan Lokasi Event', // Petunjuk buat isi lokasi
                ),
              ),
            ),
            // Tambahin jarak bawah dikit
            const SizedBox(
              height: 10, // Jarak biar nggak dempet
            ),
            // Tombol buat submit event. Sekali klik langsung beres
            Container(
              height: 50, // Tinggi tombol
              width: 150, // Lebar tombol
              decoration: BoxDecoration(
                color: Colors.blue, // Warna tombol biru, pop-up banget
                borderRadius: BorderRadius.circular(20), // Sudut melengkung, biar smooth
              ),
              child: TextButton(
                onPressed: () {
                  controller.addEvent(); // Aksi buat tambah event
                },
                child: const Text(
                  'Submit', // Tulisannya "Submit", apa lagi dong?
                  style: TextStyle(
                    color: Colors.white, // Teks putih, biar kelihatan
                    fontSize: 25, // Ukurannya gede, mencolok banget
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
