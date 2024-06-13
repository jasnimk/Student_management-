import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_management/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
late Database _db;

Future<void> initializeDataBase() async {
  try {
    _db = await openDatabase(
      'students.db',
      version: 2,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, course TEXT, adno INTEGER, contact INTEGER, img BLOB)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (newVersion < 2) {
          db.execute('ALTER TABLE Student ADD COLUMN parent TEXT');
          print('database updated');
        }
      },
    );
    print('Database initialized');
  } catch (e) {
    print('Error initializing database: $e');
  }
}

Future<void> addStudent(StudentModel value) async {
  try {
    print('Adding student: $value');
    await _db.rawInsert(
      'INSERT INTO students (name,course,adno,contact,img) VALUES(?,?,?,?,?)',
      [value.name, value.course, value.adno, value.contact, value.img],
    );
    await getAllStudents();
  } catch (e) {
    print('Error adding student: $e');
  }
}

Future<void> getAllStudents() async {
  try {
    final List<Map<String, Object?>> val =
        await _db.rawQuery('SELECT * FROM students');
    print('Students fetched: $val');
    studentListNotifier.value.clear();
    for (var map in val) {
      final student = StudentModel.fromMap(map);
      studentListNotifier.value.add(student);
    }
    studentListNotifier.notifyListeners();
  } catch (e) {
    print('Error fetching students: $e');
  }
}

Future<void> deleteStudent(int id) async {
  await _db.rawDelete('DELETE FROM students WHERE id=?', [id]);
  await getAllStudents();
}

Future<List<Map<String, Object?>>> updateStudent(
    StudentModel value, int id) async {
  print(value);
  final result = await _db.rawQuery(
      'UPDATE students SET name = ?, course = ?,adno=?,contact=?,img=? WHERE id = ?',
      [
        value.name,
        value.course,
        value.adno,
        value.contact,
        value.img,
        value.id
      ]);
  await getAllStudents();
  return result;
}
