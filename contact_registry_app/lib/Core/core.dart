import 'package:contact_registry_app/Model/contact_model.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<ContactModel>> contactNotifier = ValueNotifier([
  // ContactModel(
  //   contactId: '1',
  //   contactFirstName: 'John',
  //   contactLastName: 'Doe',
  //   contactEmail: 'john.doe@example.com',
  //   statusFavorite: '0',
  // ),
  // ContactModel(
  //   contactId: '2',
  //   contactFirstName: 'Jane',
  //   contactLastName: 'Smith',
  //   contactEmail: 'jane.smith@example.com',
  //   statusFavorite: '0',
  // ),
  // ContactModel(
  //   contactId: '3',
  //   contactFirstName: 'Robert',
  //   contactLastName: 'Johnson',
  //   contactEmail: 'robert.johnson@example.com',
  //   statusFavorite: '0',
  // ),
  // ContactModel(
  //   contactId: '4',
  //   contactFirstName: 'Emily',
  //   contactLastName: 'Davis',
  //   contactEmail: 'emily.davis@example.com',
  //   statusFavorite: '0',
  // ),
  // ContactModel(
  //   contactId: '5',
  //   contactFirstName: 'Michael',
  //   contactLastName: 'Wilson',
  //   contactEmail: 'michael.wilson@example.com',
  //   statusFavorite: '0',
  // ),
  // ContactModel(
  //   contactId: '6',
  //   contactFirstName: 'David',
  //   contactLastName: 'Taylor',
  //   contactEmail: 'david.taylor@example.com',
  //   statusFavorite: '0',
  // ),
  // ContactModel(
  //   contactId: '7',
  //   contactFirstName: 'Sarah',
  //   contactLastName: 'Anderson',
  //   contactEmail: 'sarah.anderson@example.com',
  //   statusFavorite: '0',
  // ),
  // ContactModel(
  //   contactId: '8',
  //   contactFirstName: 'James',
  //   contactLastName: 'Thomas',
  //   contactEmail: 'james.thomas@example.com',
  //   statusFavorite: '0',
  // ),
  // ContactModel(
  //   contactId: '9',
  //   contactFirstName: 'Sophia',
  //   contactLastName: 'Jackson',
  //   contactEmail: 'sophia.jackson@example.com',
  //   statusFavorite: '0',
  // ),
  // ContactModel(
  //   contactId: '10',
  //   contactFirstName: 'Anna',
  //   contactLastName: 'Brown',
  //   contactEmail: 'anna.brown@example.com',
  //   statusFavorite: '0',
  // ),
]);

final ValueNotifier<List<ContactModel>> filterContacts =
    ValueNotifier<List<ContactModel>>([]);
