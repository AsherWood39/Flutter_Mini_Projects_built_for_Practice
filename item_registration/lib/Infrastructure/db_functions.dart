// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:item_registration/Core/core.dart';
import 'package:item_registration/Model/item_category_model.dart';
import 'package:item_registration/Model/item_model.dart';
import 'package:item_registration/Model/user_model.dart';

void getAll() async {
  itemCategoryNotifier.value.clear();
  itemNotifier.value.clear();
  final documentSnapshot = await FirebaseFirestore.instance
      .collection('category')
      .get();
  print(documentSnapshot.docs.length);
  for (var doc in documentSnapshot.docs) {
    ItemCategoryModel itemCategory = ItemCategoryModel(
      itemCategoryID: doc.id,
      itemCategoryName: doc['category_name'],
    );
    itemCategoryNotifier.value.add(itemCategory);
  }
  itemCategoryNotifier.notifyListeners();

  final documentSnapshot2 = await FirebaseFirestore.instance
      .collection('items')
      .get();
  for (var doc in documentSnapshot2.docs) {
    ItemModel item = ItemModel(
      itemId: doc.id,
      itemCategoryID: doc['item_category'],
      itemName: doc['item_name'],
      itemMrp: doc['item_mrp'],
      itemSaleRate: doc['item_sale_rate'],
    );

    itemNotifier.value.add(item);
  }
  itemNotifier.notifyListeners();
}

Future<bool> addItemCategory(ItemCategoryModel c) async {
  try {
    await FirebaseFirestore.instance.collection('category').add({
      'category_name': c.itemCategoryName,
    });

    getAll();
    return Future.value(true);
  } catch (e) {
    return Future.value(false);
  }
}

void addItem(ItemModel i) async {
  try {
    await FirebaseFirestore.instance.collection('items').add({
      'item_category': i.itemCategoryID,
      'item_name': i.itemName,
      'item_mrp': i.itemMrp,
      'item_sale_rate': i.itemSaleRate,
    });

    getAll();
  } catch (e) {
    return;
  }
  itemNotifier.notifyListeners();
}

void editItem(ItemModel i) async {
  try {
    await FirebaseFirestore.instance.collection('items').doc(i.itemId).update({
      'item_category': i.itemCategoryID,
      'item_name': i.itemName,
      'item_mrp': i.itemMrp,
      'item_sale_rate': i.itemSaleRate,
    });

    getAll();
  } catch (e) {
    return;
  }
}

void deleteItem(String itemId) async {
  try {
    await FirebaseFirestore.instance.collection('items').doc(itemId).delete();

    getAll();
  } catch (e) {
    return;
  }
}

Future<bool> addUser(UserModel u) async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: u.userEmail,
          password: u.userPassword,
        );

    // ignore: unnecessary_null_comparison
    if (userCredential != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'user_name': u.userName,
            'user_email': u.userEmail,
            'user_gender': u.userGender,
            'user_address': u.userAddress,
          });
      return Future.value(true);
    }
    return Future.value(false);
  } catch (e) {
    return Future.value(false);
  }
}

Future<bool> checkLogin(UserModel u) async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: u.userEmail,
          password: u.userPassword,
        );
    // ignore: unnecessary_null_comparison
    if (userCredential != null) {
      currentUserId = userCredential.user!.uid;
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  } catch (e) {
    return Future.value(false);
  }
}

Future<UserModel> loadUser(String userId) async {
  final firebaseInstance = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .get();
  final userData = firebaseInstance.data();

  UserModel u = UserModel(
    userId,
    userData!['user_name'],
    userData['user_email'],
    '',
    userData['user_gender'],
    userData['user_address'],
  );

  return Future.value(u);
}
