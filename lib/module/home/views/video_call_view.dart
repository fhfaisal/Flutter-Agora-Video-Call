import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../videoCall/controller/doctor_call_controller.dart';
import '../../../videoCall/controller/patient_call_controller.dart';
import '../controller/video_call_controller.dart';
class VideoCallView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Patient role selected, navigate to PatientVideoCallScreen
                Get.to(() => PatientVideoCallScreen());
              },
              child: Text('Patient'),
            ),
            ElevatedButton(
              onPressed: () {
                // Doctor role selected, navigate to DoctorVideoCallScreen
                Get.to(() => DoctorVideoCallScreen());
              },
              child: Text('Doctor'),
            ),
          ],
        ),
      ),
    );
  }
}
class PatientVideoCallScreen extends StatelessWidget {
  final PatientController patientController = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Video Call'),
      ),
      body: SafeArea(
        child: Obx(() {
          // Wait until Agora is initialized
          if (!patientController.isInitialized.value) {
            return Center(child: CircularProgressIndicator());
          }

          // Start the call once the UI is built
          patientController.startCall();

          return Stack(
            children: [
              AgoraVideoViewer(
                client: patientController.agoraClient,
                layoutType: Layout.floating, // Layout for video stream
              ),
              AgoraVideoButtons(
                client: patientController.agoraClient,
                autoHideButtons: false,
                enabledButtons: const [
                  BuiltInButtons.toggleMic,
                  BuiltInButtons.toggleCamera,
                  BuiltInButtons.callEnd
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
class DoctorVideoCallScreen extends StatelessWidget {
  final DoctorController doctorController = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Video Call'),
      ),
      body: SafeArea(
        child: Obx(() {
          // Wait until Agora is initialized
          if (!doctorController.isInitialized.value) {
            return Center(child: CircularProgressIndicator());
          }

          // Accept the call once the UI is built
          doctorController.acceptCall();

          return Stack(
            children: [
              AgoraVideoViewer(
                client: doctorController.agoraClient,
                layoutType: Layout.floating, // Layout for video stream
              ),
              AgoraVideoButtons(
                client: doctorController.agoraClient,
                autoHideButtons: false,
                enabledButtons: const [
                  BuiltInButtons.toggleMic,
                  BuiltInButtons.toggleCamera,
                  BuiltInButtons.callEnd
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}