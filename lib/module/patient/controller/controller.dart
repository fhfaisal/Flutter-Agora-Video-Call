import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import '../../../utils/constants/app_id_token.dart';

class PatientController extends GetxController {
  late RtcEngine engine;
  var isInitialized = false.obs;
  var isMicOn = true.obs;
  var isCameraOn = true.obs;

  // Store the selected doctor's UID
  var selectedDoctorUid=0.obs;

  @override
  void onInit() {
    super.onInit();
    initializeAgora();
  }

  void initializeAgora() async {
    final hasPermissions = await AppIdToken.requestPermissions();
    if (!hasPermissions) return;

    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(appId: AppIdToken.id));

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print('Patient joined channel');
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          if (remoteUid == selectedDoctorUid.value) {
            print('Doctor joined with UID: $remoteUid');
          }
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          print('Doctor left the call');
        },
      ),
    );

    await engine.enableVideo();
    await engine.startPreview();

    engine.joinChannel(
      token: AppIdToken.token,
      channelId: AppIdToken.channel,
      uid: 1, // Patient's UID (Make sure this is unique)
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

