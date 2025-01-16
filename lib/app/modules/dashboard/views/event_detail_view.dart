import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EventDetailView extends GetView {
  const EventDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EventDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
