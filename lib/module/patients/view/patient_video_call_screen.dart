import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';

import '../controllers/patients_controller.dart';

class PatientVideoCallView extends StatelessWidget {
  final String channelId; // Pass the channel name (UID or doctor_123)

  PatientVideoCallView({required this.channelId, Key? key}) : super(key: key);

  final PatientController controller = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.initializeAgora(channelId), // Wait for initialization
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          // Agora client is ready, show the video call UI
          return Scaffold(
            appBar: AppBar(title: const Text('Patient Video Call')),
            body: Stack(
              children: [
                AgoraVideoViewer(
                  client: controller.agoraClient,
                  layoutType: Layout.grid, // Patient's layout view
                ),
                AgoraVideoButtons(client: controller.agoraClient),
              ],
            ),
          );
        }
      },
    );
  }
}