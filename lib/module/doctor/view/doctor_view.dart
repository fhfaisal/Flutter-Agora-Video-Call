import 'package:agora/utils/constants/app_id_token.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/doctor_call_controller.dart';

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
              // Display Local Video View (Doctor's Video)
              AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: controller.engine,
                  canvas: VideoCanvas(uid: 0), // Doctor's UID
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                width: 100,
                height: 150,
                child:
                AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: controller.engine,
                    canvas: VideoCanvas(uid: controller.patientUid), // Dynamic patient UID
                    connection: RtcConnection(channelId: AppIdToken.channel),
                  ),
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