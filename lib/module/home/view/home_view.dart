import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../doctor/view/doctor_view.dart';
import '../../patients/view/doctor_list_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Call App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => const DoctorListView());
              },
              child: const Text('Patient'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => DoctorView(doctorUid: 'doctor_123')); // Testing with a UID
              },
              child: const Text('Doctor'),
            ),
          ],
        ),
      ),
    );
  }
}




