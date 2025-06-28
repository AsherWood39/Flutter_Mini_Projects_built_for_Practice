import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management_hive/Core/core.dart';
import 'package:student_management_hive/Model/student_model.dart';

void addStudent(StudentModel s) async {
  final result = await Hive.openBox<StudentModel>('student_db');
  int id = await result.add(s);
  s.id = id.toString();
  result.put(id, s);

  getAllStudents();
}

void deleteStudent(int id) async {
  final result = await Hive.openBox<StudentModel>('student_db');
  result.delete(id);

  getAllStudents();
}

void editStudent(StudentModel s) async {
  final result = await Hive.openBox<StudentModel>('student_db');
  int id = int.parse(s.id);
  result.put(id, s);

  getAllStudents();
}

void clearStudent() async {
  final result = await Hive.openBox<StudentModel>('student_db');
  result.clear();

  getAllStudents();
}

void getAllStudents() async {
  final result = await Hive.openBox<StudentModel>('student_db');
  studentsList.value.clear();
  studentsList.value.addAll(result.values);

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentsList.notifyListeners();
}
