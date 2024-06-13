import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:student_management/model/data_model.dart';
import 'package:student_management/screens/login_screen.dart';

class StudentProfile extends StatefulWidget {
  final StudentModel student;
  const StudentProfile({super.key, required this.student});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 145, 93, 212),
        title: Text(
          'Student Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: PopupMenuButton<String>(
              onSelected: (String value) {
                // Handle menu item selection
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return LoginPage();
                }));
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'Logout',
                    child: Text('Logout'),
                  ),
                ];
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: SizedBox(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: widget.student.img != null
                    ? MemoryImage(widget.student.img! as Uint8List)
                    : null,
                child: widget.student.img == null ? Icon(Icons.person) : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        height: 70,
                        child: Card(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Name: ${widget.student.name}',
                                  style: TextStyle(fontSize: 30),
                                ))))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        height: 70,
                        child: Card(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Course: ${widget.student.course}',
                                  style: TextStyle(fontSize: 30),
                                ))))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        height: 70,
                        child: Card(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Admission No: ${widget.student.adno}',
                                  style: TextStyle(fontSize: 30),
                                ))))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        height: 80,
                        child: Card(
                            //shape: BeveledRectangleBorder(),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Contact: ${widget.student.contact}',
                                  style: TextStyle(fontSize: 30),
                                ))))),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
