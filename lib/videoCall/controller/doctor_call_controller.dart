import 'package:agora/utils/constants/app_id_token.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class DoctorController extends GetxController {
  late AgoraClient agoraClient;
  var isInitialized = false.obs; // Observable to track initialization
  final String appId = AppIdToken.id; // Replace with your Agora App ID
  final String channelName = 'doctor_channel'; // Unique channel for doctor calls
  final String tempToken = AppIdToken.token; // Replace with your token

  @override
  void onInit() {
    super.onInit();
    initAgora();
  }

  Future<void> initAgora() async {
    try {
      // Request camera and microphone permissions
      var cameraStatus = await Permission.camera.request();
      var micStatus = await Permission.microphone.request();

      // Check if both permissions are granted
      if (cameraStatus.isGranted && micStatus.isGranted) {
        // Initialize Agora client
        agoraClient = AgoraClient(
          agoraConnectionData: AgoraConnectionData(
            appId: appId,
            channelName: channelName,
            tempToken: tempToken,
          ),
        );

        await agoraClient.initialize();
        acceptCall();
        // Mark Agora as initialized
        isInitialized.value = true;
      } else {
        Get.snackbar(
          "Permissions Denied",
          "Camera and Microphone permissions are required for video calling.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to initialize Agora: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void acceptCall() {
    agoraClient.engine.joinChannel(
      token: tempToken,
      channelId: channelName,
      options: const ChannelMediaOptions(),
      uid: 0,
    );
  }

  void endCall() {
    agoraClient.engine.leaveChannel();
  }

  void toggleCamera() {
    agoraClient.engine.switchCamera();
  }

  void toggleMic() {
    agoraClient.engine.muteLocalAudioStream(true);
  }
}