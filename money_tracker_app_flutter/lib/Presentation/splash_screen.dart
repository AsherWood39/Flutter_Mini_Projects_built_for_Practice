import 'package:flutter/material.dart';
import 'package:money_tracker_app_flutter/Presentation/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    waitSplashed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/3d-logo-loader-resized.gif',
          scale: 2.5,
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Text(
          'Loading...',
          style: TextStyle(color: Color(0xFF1565C0), fontSize: 18.0),
        )
      ],
    ))));
  }

  Future<void> waitSplashed() async {
    await Future.delayed(const Duration(seconds: 5));
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
