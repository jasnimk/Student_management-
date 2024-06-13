import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'package:student_management/db_helper/db_functions.dart';
import 'package:student_management/model/data_model.dart';

class AddEditStudents extends StatefulWidget {
  const AddEditStudents({super.key});

  @override
  State<AddEditStudents> createState() => _AddEditStudentsState();
}

class _AddEditStudentsState extends State<AddEditStudents> {
  File? img;
  Uint8List? imgBytes;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        img = File(pickedFile.path);
        imgBytes = File(pickedFile.path).readAsBytesSync();
      }
    });
  }

  final nameController = TextEditingController();
  final admnController = TextEditingController();
  final courseController = TextEditingController();
  final contactController = TextEditingController();
  final guardianController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select Image'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text('From Gallery'),
                                onTap: () {
                                  _pickImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('From Camera'),
                                onTap: () {
                                  _pickImage(ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      width: 150,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: img != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                img!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.add_a_photo,
                              size: 50,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
                      height: 85,
                      child: Card(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text('Name'),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Enter the Name!',
                                    border: UnderlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Field cannot be Empty!';
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
                      height: 85,
                      child: Card(
                        child: Row(children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text('Course'),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                                controller: courseController,
                                decoration: InputDecoration(
                                    labelText: 'Enter the Course!',
                                    border: UnderlineInputBorder()),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Field cannot be Empty!';
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ]),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
                      height: 85,
                      child: Card(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text('ID'),
                            SizedBox(
                              width: 40,
                            ),
                            Expanded(
                                child: TextFormField(
                                    controller: admnController,
                                    decoration: InputDecoration(
                                      labelText: 'Enter Admission Id!',
                                      border: UnderlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Field cannot be Empty!';
                                      } else {
                                        return null;
                                      }
                                    })),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
                      height: 85,
                      child: Card(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text('Contact'),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: TextFormField(
                                    onTap: () {},
                                    controller: contactController,
                                    decoration: InputDecoration(
                                      labelText: 'Enter Contact Number!',
                                      border: UnderlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Field cannot be Empty!';
                                      } else {
                                        return null;
                                      }
                                    })),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
                      height: 85,
                      child: Card(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text('Guardian'),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: TextFormField(
                                    onTap: () {},
                                    controller: guardianController,
                                    decoration: InputDecoration(
                                      labelText: 'Enter Guardian name!',
                                      border: UnderlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Field cannot be Empty!';
                                      } else {
                                        return null;
                                      }
                                    })),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final name1 = nameController.text;
                      final course1 = courseController.text;
                      final adno1 = admnController.text;
                      final contact1 = contactController.text;
                      final guardian1 = guardianController.text;
                      final img1 = imgBytes;

                      if (name1.isEmpty ||
                          course1.isEmpty ||
                          adno1.isEmpty ||
                          contact1.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('All fields are required!')),
                        );
                      } else if (img == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Image should be added!')),
                        );
                      } else {
                        final value = StudentModel(
                            id: null,
                            name: name1,
                            course: course1,
                            adno: adno1,
                            contact: contact1,
                            guardian: guardian1,
                            img: img1);
                        // addStudent(value);
                        if (value != 0) {
                          addStudent(value);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Data saved successfully')),
                          );
                          // imgBytes = null;
                          clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to save data')),
                          );
                        }
                      }
                    },
                    label: Text('Save'),
                    icon: Icon(Icons.save),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        clear();
                      },
                      label: Text('Clear'),
                      icon: Icon(Icons.clear),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void clear() {
    setState(() {
      img = null;
      imgBytes = null;
      nameController.text = '';
      contactController.text = '';
      courseController.text = '';
      admnController.text = '';
    });
  }
}
