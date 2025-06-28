// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:student_management_hive/Core/core.dart';
import 'package:student_management_hive/Infrastructure/db_functions.dart';
import 'package:student_management_hive/Model/student_model.dart';

class ScreenStudentHome extends StatelessWidget {
  ScreenStudentHome({super.key});

  final studentNameController = TextEditingController();
  final studentRollNoController = TextEditingController();
  final studentMarksController = TextEditingController();

  final nameFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String? editFlag = '0';
  String? studentId = '';

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Students Management',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: studentNameController,
                        focusNode: nameFocusNode,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Student Name Required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Student Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: studentRollNoController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Student Roll Number Required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Student Roll Number',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: studentMarksController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Student Marks Required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Student Marks',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (editFlag == '0') {
                                    addStudent(
                                      StudentModel(
                                        id: '',
                                        studentName: studentNameController.text,
                                        studentRollNumber:
                                            studentRollNoController.text,
                                        studentMarks:
                                            studentMarksController.text,
                                      ),
                                    );
                                  } else {
                                    editStudent(
                                      StudentModel(
                                        id: studentId!,
                                        studentName: studentNameController.text,
                                        studentRollNumber:
                                            studentRollNoController.text,
                                        studentMarks:
                                            studentMarksController.text,
                                      ),
                                    );
                                    editFlag = '0';
                                  }
                                  studentNameController.clear();
                                  studentRollNoController.clear();
                                  studentMarksController.clear();

                                  FocusScope.of(context).unfocus();
                                }
                              },
                              child: Text(
                                editFlag == '0' ? 'Add Student' : 'Save',
                              ),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                clearStudent();
                              },
                              child: Text('Clear'),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.indigo),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              child: ValueListenableBuilder(
                valueListenable: studentsList,
                builder: (context, List<StudentModel> newStudentsList, _) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      var studentData = newStudentsList[index];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo,
                          radius: 25,
                          child: Text(
                            studentData.studentName[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(studentData.studentName),
                        subtitle: Row(
                          children: [
                            Text(
                              'Roll Number: ${studentData.studentRollNumber}',
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                editFlag = '1';

                                studentNameController.text =
                                    studentData.studentName;
                                studentRollNoController.text =
                                    studentData.studentRollNumber;
                                studentMarksController.text =
                                    studentData.studentMarks;

                                FocusScope.of(
                                  context,
                                ).requestFocus(nameFocusNode);

                                studentId = studentData.id;
                              },
                              icon: const Icon(Icons.edit, size: 20.0),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteStudent(int.parse(studentData.id));
                              },
                              icon: const Icon(Icons.delete, size: 20.0),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        trailing: Text(studentData.studentMarks),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: newStudentsList.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
