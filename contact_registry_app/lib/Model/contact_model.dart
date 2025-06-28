// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/adapters.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 1)
class ContactModel {
  @HiveField(0)
  String? contactId;
  @HiveField(1)
  String contactFirstName;
  @HiveField(2)
  String contactLastName;
  @HiveField(3)
  String contactEmail;
  @HiveField(4)
  String statusFavorite;

  ContactModel({
    required this.contactId,
    required this.contactFirstName,
    required this.contactLastName,
    required this.contactEmail,
    required this.statusFavorite,
  });
}
