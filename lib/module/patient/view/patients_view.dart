import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import '../../../utils/constants/app_id_token.dart';
import '../controller/controller.dart';

class PatientVideoCallScreen extends StatelessWidget {
  final int doctorUid; // Receive doctor UID from the previous screen
  final PatientController controller = Get.put(PatientController());

  PatientVideoCallScreen({required this.doctorUid}) {
    // Store the selected doctor UID in the controller
    controller.selectedDoctorUid.value = doctorUid;
   // controller.initializeAgora(); // Start video call
  }

  @override
  Widget build(BuildContext context) {
    print(doctorUid);
    print(controller.selectedDoctorUid);
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (!controller.isInitialized.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              // Display Remote Video View (Doctor's Video)
              AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: controller.engine,
                  canvas: VideoCanvas(uid: controller.selectedDoctorUid.value), // Doctor's UID
                  connection: RtcConnection(channelId: AppIdToken.channel),
                ),
              ),
              // Display Local Video View (Patient's Video)
              Positioned(
                top: 20,
                left: 20,
                width: 100,
                height: 150,
                child: AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: controller.engine,
                    canvas: VideoCanvas(uid: 0), // Local UID
                  ),
                ),
              ),
              // Display Floating Action Buttons for Controls
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      icon: controller.isMicOn.value ? Icons.mic : Icons.mic_off,
                      onPressed: controller.toggleMic,
                    ),
                    _buildControlButton(
                      icon: Icons.call_end,
                      color: Colors.red,
                      onPressed: controller.endCall,
                    ),
                    _buildControlButton(
                      icon: controller.isCameraOn.value
                          ? Icons.videocam
                          : Icons.videocam_off,
                      onPressed: controller.toggleCamera,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color color = Colors.white,
  }) {
    return FloatingActionButton(
      backgroundColor: color,
      child: Icon(icon, color: Colors.black),
      onPressed: onPressed,
    );
  }
}

