import 'package:agora/module/patients/view/patient_video_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DoctorListView extends StatelessWidget {
  const DoctorListView({super.key});

  final List<Map<String, String>> doctors = const [
    {'name': 'Dr. John', 'uid': 'doctor_123'},
    {'name': 'Dr. Alice', 'uid': 'doctor_456'},
    {'name': 'Dr. Mike', 'uid': 'doctor_789'},
    {'name': 'Dr. Sarah', 'uid': 'doctor_101'},
    {'name': 'Dr. Emma', 'uid': 'doctor_102'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select a Doctor')),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return ListTile(
            title: Text(doctor['name']!),
            onTap: () {
              print(doctor['uid']!);
              Get.to(() => PatientVideoCallView(channelId: doctor['uid']!,));
            },
          );
        },
      ),
    );
  }
}