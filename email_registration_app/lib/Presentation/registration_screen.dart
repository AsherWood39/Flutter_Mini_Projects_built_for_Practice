import 'package:firebase_practice_project/Infrastructure/db_functions.dart';
import 'package:firebase_practice_project/Model/user_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScreenRegistration extends StatelessWidget {
  ScreenRegistration({super.key});
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userPasswordReconfirmController = TextEditingController();
  final userAddressController = TextEditingController();
  List<String> userGender = ['Male', 'Female', 'Other'];
  final _regFormKey = GlobalKey<FormState>();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('User Registration', style: TextStyle(color: Colors.white)),
      ),
      body: Form(
        key: _regFormKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: userNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: userEmailController,
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
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: userPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password required';
                  } else if (value.length < 5) {
                    return 'minimum password length is six';
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
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: userPasswordReconfirmController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password required';
                  } else if (value != userPasswordController.text) {
                    return 'Passwords mismatch';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Reconfirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: DropdownButtonFormField(
                validator: (value) {
                  if (value == null) {
                    return 'Gender Required';
                  }
                  return null;
                },
                items: userGender.map((gender) {
                  return DropdownMenuItem(value: gender, child: Text(gender));
                }).toList(),
                hint: Text('Gender'),

                value: selectedGender,
                onChanged: (newGender) {
                  selectedGender = newGender;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: userAddressController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Address required';
                  }
                  return null;
                },
                maxLines: 5,

                decoration: InputDecoration(
                  hintText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_regFormKey.currentState!.validate()) {
                    bool success = await addUser(
                      UserModel(
                        '',
                        userNameController.text,
                        userEmailController.text,
                        userPasswordController.text,
                        selectedGender!,
                        userAddressController.text,
                      ),
                    );

                    final snackBar = SnackBar(
                      content: Text(
                        success == true
                            ? 'Successfully Registered'
                            : 'Error: Error in registering the User',
                      ),
                      action: SnackBarAction(label: 'ok', onPressed: () {}),
                    );

                    if (success == true) {
                      Navigator.of(context).pop();
                    }

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
