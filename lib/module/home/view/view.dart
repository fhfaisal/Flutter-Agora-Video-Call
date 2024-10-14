
import 'package:agora/module/patient/view/doctors_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../doctor/view/doctor_view.dart';
import '../../patient/view/patients_view.dart';
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
                Get.to(() => DoctorListScreen());
                //Get.to(() => PatientHomeScreen());
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


