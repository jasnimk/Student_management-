import 'dart:io';
//import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/db_helper/db_functions.dart';
import 'package:student_management/model/data_model.dart';

class EditStudents extends StatefulWidget {
  final StudentModel student;

  const EditStudents({Key? key, required this.student}) : super(key: key);

  @override
  State<EditStudents> createState() => _EditStudentsState();
}

class _EditStudentsState extends State<EditStudents> {
  File? img;
  Uint8List? imgBytes;

  Uint8List? imgBytes1;

  final nameController = TextEditingController();
  final admnController = TextEditingController();
  final courseController = TextEditingController();
  final contactController = TextEditingController();
  final guardianController = TextEditingController();
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        img = File(pickedFile.path);
        imgBytes = File(pickedFile.path).readAsBytesSync();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.student.name;
    courseController.text = widget.student.course.toString();
    admnController.text = widget.student.adno.toString();
    contactController.text = widget.student.contact.toString();

    imgBytes = widget.student.img;

    // if (imgBytes1 != null) {
    //   img = File.fromRawPath(imgBytes!);
    // }
  }

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
                      child: imgBytes != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                imgBytes!,
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
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: buildTextField('Name', nameController),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: buildTextField('Course', courseController),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: buildTextField('ID', admnController),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: buildTextField('Contact', contactController),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: updateStudentInfo,
                    label: Text('Update'),
                    icon: Icon(Icons.update),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: ElevatedButton.icon(
                      onPressed: clear,
                      label: Text('Clear'),
                      icon: Icon(Icons.clear),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Container(
      height: 85,
      child: Card(
        child: Row(
          children: [
            SizedBox(width: 20),
            Text(label),
            SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Enter the $label!',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field cannot be Empty!';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  Future<void> updateStudentInfo() async {
    if (imgBytes == null) {
      // Changed to check imgBytes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image should be added!')),
      );
      return;
    }

    final name = nameController.text.trim();
    final course = courseController.text.trim();
    final adno = admnController.text.trim();
    final contact = contactController.text.trim();
    final guardian = guardianController.text.trim();

    final student = StudentModel(
      id: widget.student.id,
      name: name,
      course: course,
      adno: adno,
      contact: contact,
      guardian: guardian,
      img: imgBytes,
    );
    //print(img);
    final result = await updateStudent(student, widget.student.id!);

    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data updated successfully')),
      );
      clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update data')),
      );
    }
  }

  void clear() {
    setState(() {
      img = null;
      imgBytes = null;
      nameController.clear();
      courseController.clear();
      admnController.clear();
      contactController.clear();
    });
  }
}
