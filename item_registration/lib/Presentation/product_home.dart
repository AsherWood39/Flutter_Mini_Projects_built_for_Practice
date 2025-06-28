// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:item_registration/Core/core.dart';
import 'package:item_registration/Infrastructure/db_functions.dart';
import 'package:item_registration/Model/item_category_model.dart';
import 'package:item_registration/Model/item_model.dart';
import 'package:item_registration/Model/user_model.dart';

// ignore: must_be_immutable
class ScreenProductHome extends StatelessWidget {
  UserModel user;
  ScreenProductHome({required this.user, super.key});

  final itemCategoryController = TextEditingController();
  String? selectedItemCategory;
  final itemNameController = TextEditingController();
  final itemMrpController = TextEditingController();
  final itemSaleRateController = TextEditingController();
  final _formItemCategory = GlobalKey<FormState>();
  final _formItem = GlobalKey<FormState>();
  int itemCategoryId = 0;
  int itemId = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllOnce(),
      builder: (context, asyncSnapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            title: Center(
              child: Text(
                'Welcome ${user.userName}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                child: ValueListenableBuilder(
                  valueListenable: itemNotifier,
                  builder: (context, List<ItemModel> newItemList, _) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        var itemData = newItemList[index];
                        return Slidable(
                          key: ValueKey(itemData.itemId),
                          startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  ItemModel i = ItemModel(
                                    itemId: itemData.itemId,
                                    itemCategoryID: itemData.itemCategoryID,
                                    itemName: itemData.itemName,
                                    itemMrp: itemData.itemMrp,
                                    itemSaleRate: itemData.itemSaleRate,
                                  );
                                  showItemEditPopUp(context, i);
                                },
                                backgroundColor: Colors.blue,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  showDeletePopUp(context, itemData.itemId);
                                },
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.lightGreen,
                              child: Text(
                                '${index + 1}'.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  color: const Color.fromARGB(255, 21, 58, 23),
                                ),
                              ),
                            ),
                            title: Text(itemData.itemName),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('MRP: ${itemData.itemMrp}'),
                                    SizedBox(width: 10),
                                    Text('Sale Rate: ${itemData.itemSaleRate}'),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    getItemCategory(itemData.itemCategoryID),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: newItemList.length,
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: FloatingActionButton(
                  onPressed: () {
                    showItemCategoryPopUp(context);
                  },
                  tooltip: 'Add Category',
                  child: Icon(Icons.category, color: Colors.pink),
                ),
              ),
              Spacer(),
              FloatingActionButton(
                onPressed: () {
                  showItemPopUp(context);
                },
                tooltip: 'Add Item',
                child: Icon(Icons.shopping_cart_checkout, color: Colors.indigo),
              ),
            ],
          ),
        );
      },
    );
  }

  String getItemCategory(String itemCatId) {
    String itemCategoryName = '';
    for (var doc in itemCategoryNotifier.value) {
      if (doc.itemCategoryID == itemCatId) {
        itemCategoryName = doc.itemCategoryName;
      }
    }
    return itemCategoryName;
  }

  void showItemCategoryPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Add Item Category')),
          content: SizedBox(
            height: 70,
            child: Form(
              key: _formItemCategory,
              child: Column(
                children: [
                  TextFormField(
                    controller: itemCategoryController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Category required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Category Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (_formItemCategory.currentState!.validate()) {
                  itemCategoryId = itemCategoryId + 1;
                  ItemCategoryModel c = ItemCategoryModel(
                    itemCategoryID: itemCategoryId.toString(),
                    itemCategoryName: itemCategoryController.text,
                  );
                  bool flag = await addItemCategory(c);
                  ScaffoldMessenger(
                    child: SnackBar(
                      content: Text(
                        flag == true
                            ? 'Category added Successfully'
                            : 'Unsuccessful in adding the Category',
                      ),
                    ),
                  );
                  itemCategoryController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showItemPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Add Item ')),
          content: SingleChildScrollView(
            child: Form(
              key: _formItem,
              child: Column(
                children: [
                  TextFormField(
                    controller: itemNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Item required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Item Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    hint: Text('Select an Item Category'),
                    validator: (value) {
                      if (value == null) {
                        return 'Category required';
                      }
                      return null;
                    },
                    items: itemCategoryNotifier.value.map((category) {
                      return DropdownMenuItem(
                        value: category.itemCategoryID,
                        child: Text(category.itemCategoryName),
                      );
                    }).toList(),
                    value: selectedItemCategory,
                    onChanged: (newItemCategory) {
                      selectedItemCategory = newItemCategory;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: itemMrpController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'MRP required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Item MRP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: itemSaleRateController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Sale Rate required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Item Sale Rate',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_formItem.currentState!.validate()) {
                  itemId = itemId + 1;
                  ItemModel i = ItemModel(
                    itemId: itemId.toString(),
                    itemCategoryID: selectedItemCategory!,
                    itemName: itemNameController.text,
                    itemMrp: itemMrpController.text,
                    itemSaleRate: itemSaleRateController.text,
                  );
                  addItem(i);
                  itemNameController.clear();
                  itemMrpController.clear();
                  itemSaleRateController.clear();
                  selectedItemCategory = null;
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showItemEditPopUp(BuildContext context, ItemModel item) {
    itemNameController.text = item.itemName;
    selectedItemCategory = item.itemCategoryID;
    itemMrpController.text = item.itemMrp;
    itemSaleRateController.text = item.itemSaleRate;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Edit Item ')),
          content: SingleChildScrollView(
            child: Form(
              key: _formItem,
              child: Column(
                children: [
                  TextFormField(
                    controller: itemNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Item required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Item Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    hint: Text('Select an Item Category'),
                    validator: (value) {
                      if (value == null) {
                        return 'Category required';
                      }
                      return null;
                    },
                    items: itemCategoryNotifier.value.map((category) {
                      return DropdownMenuItem(
                        value: category.itemCategoryID,
                        child: Text(category.itemCategoryName),
                      );
                    }).toList(),
                    value: selectedItemCategory,
                    onChanged: (newItemCategory) {
                      selectedItemCategory = newItemCategory;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: itemMrpController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'MRP required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Item MRP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: itemSaleRateController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Sale Rate required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Item Sale Rate',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_formItem.currentState!.validate()) {
                  ItemModel i = ItemModel(
                    itemId: item.itemId,
                    itemCategoryID: selectedItemCategory!,
                    itemName: itemNameController.text,
                    itemMrp: itemMrpController.text,
                    itemSaleRate: itemSaleRateController.text,
                  );
                  editItem(i);
                  itemNameController.clear();
                  itemMrpController.clear();
                  itemSaleRateController.clear();
                  selectedItemCategory = null;
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showDeletePopUp(BuildContext context, String itemId) {
    showDialog(
      context: context,
      builder: (BuildContext alertContext) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Are you sure about this?',
              style: TextStyle(
                color: Color(0xFFD32F2F),
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(alertContext).pop();
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    deleteItem(itemId);

                    itemNotifier.notifyListeners();

                    Navigator.of(alertContext).pop();
                  },
                  child: Text('Yes'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
