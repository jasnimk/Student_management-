import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:student_management/db_helper/db_functions.dart';
import 'package:student_management/model/data_model.dart';
import 'package:student_management/screens/edit_students.dart';
import 'package:student_management/screens/student_profile.dart';

class ViewStudentList extends StatefulWidget {
  const ViewStudentList({Key? key}) : super(key: key);

  @override
  State<ViewStudentList> createState() => _ViewStudentListState();
}

class _ViewStudentListState extends State<ViewStudentList> {
  bool gridViewValue = false;
  final textController = TextEditingController();
  ValueNotifier<List<StudentModel>> filteredStudentListNotifier =
      ValueNotifier([]);
  //get a => filteredStudentListNotifier;

  @override
  void initState() {
    super.initState();
    getAllStudents();
    textController.addListener(filterStudents);
    studentListNotifier.addListener(updateStudentList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                gridViewValue = !gridViewValue;
              });
            },
            icon: Icon(gridViewValue ? Icons.list : Icons.grid_view),
            color: Colors.white,
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 145, 93, 212),
        title: Text(
          'STUDENT LIST',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap the column with SingleChildScrollView
          physics: AlwaysScrollableScrollPhysics(), // Enable scrolling
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search here!',
                  ),
                ),
              ),
              gridViewValue ? listView() : gridView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget listView() {
    return ValueListenableBuilder(
      valueListenable: filteredStudentListNotifier,
      builder: (context, List<StudentModel> studentList, child) {
        if (studentList.isEmpty) {
          return Center(
            child: Text('No Students Found!'),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                child: ListTile(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StudentProfile(student: studentList[index])))
                  },
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          data.img != null ? MemoryImage(data.img!) : null,
                      child: data.img == null ? Icon(Icons.person) : null,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.name),
                      Text(data.course.toString()),
                      Text(data.contact.toString()),
                      Text(data.guardian.toString()),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDelete(ctx, data.id);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return EditStudents(
                              student: data,
                            );
                          }));
                          // Add your edit functionality here
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return SizedBox();
          },
          itemCount: studentList.length,
        );
      },
    );
  }

  Widget gridView() {
    return ValueListenableBuilder(
      valueListenable: filteredStudentListNotifier,
      builder: (context, List<StudentModel> studentList, child) {
        if (studentList.isEmpty) {
          return Center(
            child: Text('No students found'),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (50.0 / 65.5), // Number of columns in the grid
            crossAxisSpacing: 10.0, // Horizontal spacing between items
            mainAxisSpacing: 10.0, // Vertical spacing between items
          ),
          itemCount: studentList.length,
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StudentProfile(student: studentList[index])))
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: data.img != null
                                ? MemoryImage(data.img! as Uint8List)
                                : null,
                            child: data.img == null ? Icon(Icons.person) : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Text(data.name, style: TextStyle(fontSize: 16)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(data.course.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(data.contact.toString()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDelete(ctx, data.id);
                              },
                              icon: Icon(Icons.delete),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return EditStudents(
                                    student: data,
                                  );
                                }));
                                // Add your edit functionality here
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          },
        );
      },
    );
  }

  void showDelete(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are you sure?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                deleteStudent(id);
                filterStudents();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void filterStudents() {
    final textToSearch = textController.text.toLowerCase();
    final allStudents = studentListNotifier.value;
    final filteredStudents = allStudents.where((student) {
      return student.name.toLowerCase().contains(textToSearch) ||
          student.course!.toLowerCase().contains(textToSearch) ||
          student.contact!.toLowerCase().contains(textToSearch) ||
          student.adno.toString().contains(textToSearch);
    }).toList();
    filteredStudentListNotifier.value = filteredStudents;
  }

  void updateStudentList() {
    filteredStudentListNotifier.value = studentListNotifier.value;
  }

  void dispose() {
    textController.removeListener(filterStudents);
    textController.dispose();
    // studentListNotifier.removeListener(filterStudents);
    // super.dispose();
  }
}
