import 'package:contact_registry_app/Core/core.dart';
import 'package:contact_registry_app/Infrastructure/db_functions.dart';
import 'package:contact_registry_app/Model/contact_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContactDetails extends StatelessWidget {
  String? type;
  final ContactModel? contact;

  ContactDetails({super.key, required this.type, this.contact});

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (type == '1' && contact != null) {
      firstNameController.text = contact!.contactFirstName;
      lastNameController.text = contact!.contactLastName;
      emailController.text = contact!.contactEmail;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ValueListenableBuilder(
          valueListenable: contactNotifier,
          builder: (context, List<ContactModel> newContact, _) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First Name is Required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        hintText: 'First Name',
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Last Name is Required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        hintText: 'Last Name',
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (value == null || value.isEmpty) {
                          return 'Email is Required';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        hintText: 'Email',
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            firstNameController.clear();
                            lastNameController.clear();
                            emailController.clear();

                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (type == '0') {
                                addContact(
                                  ContactModel(
                                    contactId: '',
                                    contactFirstName: firstNameController.text,
                                    contactLastName: lastNameController.text,
                                    contactEmail: emailController.text,
                                    statusFavorite: '0',
                                  ),
                                );
                              } else {
                                editContact(
                                  ContactModel(
                                    contactId: contact!.contactId,
                                    contactFirstName: firstNameController.text,
                                    contactLastName: lastNameController.text,
                                    contactEmail: emailController.text,
                                    statusFavorite: contact!.statusFavorite,
                                  ),
                                );
                              }

                              firstNameController.clear();
                              lastNameController.clear();
                              emailController.clear();
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(type == '0' ? 'Add' : 'Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
