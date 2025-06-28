import 'package:contact_registry_app/Core/core.dart';
import 'package:contact_registry_app/Model/contact_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void getAllContacts() async {
  final result = await Hive.openBox<ContactModel>('contact_db');
  contactNotifier.value.clear();
  contactNotifier.value.addAll(result.values);

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  contactNotifier.notifyListeners();
}

void addContact(ContactModel c) async {
  final result = await Hive.openBox<ContactModel>('contact_db');
  final id = await result.add(c);
  c.contactId = id.toString();
  await result.put(id, c);

  getAllContacts();
}

void editContact(ContactModel c) async {
  int id = int.parse(c.contactId!);
  final result = await Hive.openBox<ContactModel>('contact_db');
  await result.put(id, c);

  getAllContacts();
}

void statusFavorite(ContactModel c) async {
  int id = int.parse(c.contactId!);
  final result = await Hive.openBox<ContactModel>('contact_db');
  c.statusFavorite = c.statusFavorite == '0' ? '1' : '0';
  await result.put(id, c);

  getAllContacts();
}
