import 'package:agora/module/patient/model/model.dart';
import 'package:agora/module/patient/view/patients_view.dart';
import 'package:agora/utils/constants/app_id_token.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Doctor'),
      ),
      body: ListView.builder(
        itemCount: Doctor.doctors.length,
        itemBuilder: (context, index) {
          final doctor = Doctor.doctors[index];
          return Card(
            child: ListTile(
              title: Text(doctor.name),
              subtitle: Text(doctor.specialization),
              trailing: Icon(Icons.video_call),
              onTap: () {
                // Pass the selected doctor’s ID to the call screen
                Get.to(() => PatientVideoCallScreen(doctorUid: doctor.id));
                print('Calling doctor ${doctor.id}');
                print('Calling doctor ${AppIdToken.channel}');
              },
            ),
          );
        },
      ),
    );
  }
}
