import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice_project/Presentation/login_screen.dart';
import 'package:firebase_practice_project/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ScreenLogin());
  }
}
