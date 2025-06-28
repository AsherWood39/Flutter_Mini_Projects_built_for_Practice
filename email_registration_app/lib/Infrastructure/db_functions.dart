import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice_project/Core/core.dart';
import 'package:firebase_practice_project/Model/user_model.dart';

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

Future<bool> editUser(UserModel u) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(u.userId).update({
      'user_name': u.userName,
      'user_email': u.userEmail,
      'user_gender': u.userGender,
      'user_address': u.userAddress,
    });
    return true;
  } catch (e) {
    return false;
  }
}
