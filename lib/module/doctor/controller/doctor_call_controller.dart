import 'package:agora/utils/constants/app_id_token.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class DoctorController extends GetxController {
  late RtcEngine engine;
  var isInitialized = false.obs;
  var isMicOn = true.obs;
  var isCameraOn = true.obs;
  var patientUid = 1; // Variable to store the remote patient's UID

  @override
  void onInit() {
    super.onInit();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    final hasPermissions = await AppIdToken.requestPermissions();
    if (!hasPermissions) return;

    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(appId: AppIdToken.id));

    await engine.enableVideo();
    await engine.startPreview();
    isInitialized.value = true;
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print('Doctor joined channel');
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          patientUid = remoteUid;  // Save the patient's UID
          print('Patient joined with UID: $remoteUid');
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          print('Patient left the call');
        },
      ),
    );

    await engine.enableVideo();
    await engine.startPreview();

    await engine.joinChannel(
      token: AppIdToken.token,
      channelId: AppIdToken.channel,
      uid: 101, // Doctor's UID
      options: const ChannelMediaOptions(),
    );

    isInitialized.value = true;
  }

  void toggleMic() {
    isMicOn.value = !isMicOn.value;
    engine.muteLocalAudioStream(!isMicOn.value);
  }

  void toggleCamera() {
    isCameraOn.value = !isCameraOn.value;
    engine.muteLocalVideoStream(!isCameraOn.value);
  }

  void endCall() {
    engine.leaveChannel();
    Get.back();
  }
}
