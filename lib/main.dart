
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'module/home/view/view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Patient Video Call App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoCallView(),
    );
  }
}
