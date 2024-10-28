import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop/controllers/home_controller.dart';
import 'package:my_shop/screens/data.dart';

import 'controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  Get.put(MainController());
  // uploadData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharma',
      theme: ThemeData(
        // scaffoldBackgroundColor: bgColor,
        primarySwatch: Colors.indigo,
        fontFamily: "Gordita",
        // appBarTheme: const AppBarTheme(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        // textTheme: const TextTheme(
        //   bodyText2: TextStyle(color: Colors.black54),
        // ),
      ),
      home: controller.route,
    );
  }
}
