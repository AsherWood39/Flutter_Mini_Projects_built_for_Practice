//import 'package:contact_registry_app/Presentation/contact_details.dart';
import 'package:contact_registry_app/Model/contact_model.dart';
import 'package:contact_registry_app/Presentation/contact_home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ContactModelAdapter().typeId)) {
    Hive.registerAdapter(ContactModelAdapter());
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ContactHome());
  }
}
