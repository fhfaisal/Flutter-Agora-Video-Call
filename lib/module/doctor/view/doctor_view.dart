import 'package:agora/utils/constants/app_id_token.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/doctor_controller.dart';
import 'doctor_video_call_screen.dart';

class DoctorView extends StatelessWidget {
  final String doctorUid;

  DoctorView({required this.doctorUid, super.key});

  final DoctorController controller = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Dashboard')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => DoctorVideoCallView(channelId: 'doctor_123'));
          },
          child: const Text('Join Call'),
        )
      ),
    );
  }
}
