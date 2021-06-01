import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todoapp/database/initialize_db.dart';
import 'package:todoapp/modules/get_started/screens/get_started_screen.dart';
import 'package:todoapp/theme/generate_material_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeData.initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android,
        primarySwatch: generateMaterialColor(Color(0xff4a148c)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GetStartedScreen(),
    );
  }
}
