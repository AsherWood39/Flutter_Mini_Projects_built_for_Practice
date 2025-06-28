import 'package:firebase_practice_project/Core/core.dart';
import 'package:firebase_practice_project/Infrastructure/db_functions.dart';
import 'package:firebase_practice_project/Model/user_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScreenUserHome extends StatelessWidget {
  UserModel user;
  ScreenUserHome({required this.user, super.key});

  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userAddressController = TextEditingController();
  String? selectedGender;
  List<String> userGender = ['Male', 'Female', 'Other'];
  final _regFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    userNameController.text = user.userName;
    userEmailController.text = user.userEmail;
    userAddressController.text = user.userAddress;
    selectedGender = user.userGender;
    List<String> userGender = ['Male', 'Female', 'Other'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Welcome ${user.userName}',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              isEditableNotifier.value = true;
            },
            icon: Icon(Icons.edit, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: Form(
        key: _regFormKey,
        child: ValueListenableBuilder(
          valueListenable: isEditableNotifier,
          builder: (context, bool newIsEditable, _) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    enabled: newIsEditable,
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
                    enabled: newIsEditable,
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
                  child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Gender Required';
                      }
                      return null;
                    },
                    items: userGender.map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    hint: Text('Gender'),

                    value: selectedGender,
                    onChanged: newIsEditable == true
                        ? (newGender) {
                            selectedGender = newGender as String?;
                          }
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    enabled: newIsEditable,

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
                    onPressed: newIsEditable == true
                        ? () async {
                            if (_regFormKey.currentState!.validate()) {
                              bool flag = await editUser(
                                UserModel(
                                  user.userId,
                                  userNameController.text,
                                  userEmailController.text,
                                  user.userPassword,
                                  selectedGender!,
                                  userAddressController.text,
                                ),
                              );

                              if (flag == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Updated Successful')),
                                );
                                Navigator.of(context).pop();
                              } else {
                                userNameController.text = user.userName;
                                userEmailController.text = user.userEmail;
                                selectedGender = user.userGender;
                                userAddressController.text = user.userAddress;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Couldn\'t edit. Try again'),
                                    action: SnackBarAction(
                                      label: 'ok',
                                      onPressed: () {},
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        : null,
                    child: Text('Save Changes'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
