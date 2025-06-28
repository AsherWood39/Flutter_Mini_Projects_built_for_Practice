import 'package:firebase_practice_project/Core/core.dart';
import 'package:firebase_practice_project/Infrastructure/db_functions.dart';
import 'package:firebase_practice_project/Model/user_model.dart';
import 'package:firebase_practice_project/Presentation/home_screen.dart';
import 'package:firebase_practice_project/Presentation/registration_screen.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginAFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('asset/background_image.jpg'),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _loginAFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/11753/11753627.png',
                    ),
                    height: 90,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_loginAFormKey.currentState!.validate()) {
                            final flag = await checkLogin(
                              UserModel(
                                '',
                                '',
                                emailController.text,
                                passwordController.text,
                                '',
                                '',
                              ),
                            );

                            if (flag == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login Successful')),
                              );

                              final user = await loadUser(currentUserId);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ScreenUserHome(user: user),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Invalid User Credentials. Try again',
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreenRegistration(),
                        ),
                      );
                    },
                    child: Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.indigo,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
