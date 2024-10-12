

import 'package:agora/utils/constants/app_id_token.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/doctor_call_controller.dart';
import '../controller/patient_call_controller.dart';

class VideoCallView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Role")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to PatientVideoCallScreen
                Get.to(() => PatientVideoCallScreen());
              },
              child: Text("I am a Patient"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to DoctorVideoCallScreen
                Get.to(() => DoctorVideoCallScreen());
              },
              child: Text("I am a Doctor"),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorVideoCallScreen extends StatelessWidget {
  final DoctorController controller = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (!controller.isInitialized.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              // Local video view (doctor's own preview)
              AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: controller.engine,
                  canvas: const VideoCanvas(uid: 0), // Doctor's UID
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      icon: controller.isMicOn.value
                          ? Icons.mic
                          : Icons.mic_off,
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
class PatientVideoCallScreen extends StatelessWidget {
  final PatientController controller = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (!controller.isInitialized.value) {
            return Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              // Local video view (patient's own preview)
              AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: controller.engine,
                  canvas: VideoCanvas(uid: 0), // Patient's UID (0)
                ),
              ),
              // Remote video view (doctor's video)
              AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: controller.engine,
                  canvas: VideoCanvas(uid: controller.doctorUserId), // Doctor's UID
                  connection: RtcConnection(
                    channelId: AppIdToken.channel, // Pass the correct channel ID
                  ),
                ),
              ),
              // Control buttons can be added here
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      icon: controller.isMicOn.value
                          ? Icons.mic
                          : Icons.mic_off,
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


