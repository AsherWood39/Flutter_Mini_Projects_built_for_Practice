import 'package:contact_registry_app/Core/core.dart';
import 'package:contact_registry_app/Infrastructure/db_functions.dart';
import 'package:contact_registry_app/Model/contact_model.dart';
import 'package:contact_registry_app/Presentation/contact_details.dart';
import 'package:flutter/material.dart';

class ContactHome extends StatelessWidget {
  ContactHome({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllContacts();
    });

    if (filterContacts.value.isEmpty) {
      filterContacts.value = List.from(contactNotifier.value);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .15,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (query) {
                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                    contactNotifier.notifyListeners();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    filled: true,
                    fillColor: Colors.grey[800], // Dark background color
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 15.0,
                    ),
                    prefixIcon: Icon(Icons.search_rounded, color: Colors.white),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ), // To avoid icon overflow
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Ensures the row takes the least space
                        children: [
                          Icon(Icons.mic_rounded, color: Colors.white),
                          Icon(Icons.more_vert_rounded, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  style: TextStyle(color: Colors.white), // White text color
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              child: ValueListenableBuilder(
                valueListenable: contactNotifier,
                builder: (context, List<ContactModel> newContact, child) {
                  final query = searchController.text.toLowerCase();
                  final filteredList = query.isEmpty
                      ? newContact
                      : newContact
                            .where(
                              (contact) => contact.contactFirstName
                                  .toLowerCase()
                                  .contains(query),
                            )
                            .toList();
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      var contactData = filteredList[index];
                      return ListTile(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ContactDetails(type: '1', contact: contactData),
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFF1565C0),
                          child: Text(
                            contactData.contactFirstName[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        title: Text(
                          contactData.contactFirstName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            statusFavorite(contactData);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: contactData.statusFavorite == '0'
                                ? Colors.grey
                                : Colors.amber,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: filteredList.length,
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ContactDetails(type: '0'),
              ),
            );
            if (result != null) {
              getAllContacts(); // Refresh list after returning
            }
          },
          child: Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}
