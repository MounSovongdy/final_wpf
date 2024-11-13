import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/firebase_options.dart';
import 'package:motor/screens/login_screen.dart';
import 'package:motor/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final con = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Motor Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      //home: LoginScreen(),
      home:  MainScreen(),
    );
  }
}
