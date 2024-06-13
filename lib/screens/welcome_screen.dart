import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:student_management/add_edit_students.dart';
import 'package:student_management/screens/add_students.dart';
import 'package:student_management/screens/login_screen.dart';
import 'package:student_management/screens/view_student_list.dart';
// import 'package:student_management/view_student_list.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final a = const Color.fromARGB(255, 255, 255, 255);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 145, 93, 212),
        title: const Text(
          'Welcome!',
          style: TextStyle(color: Colors.white),
        ),
        //centerTitle: true,
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: PopupMenuButton<String>(
              onSelected: (String value) {
                // Handle menu item selection
                showLogout(context);
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'Logout',
                    child: Text('Logout'),
                  ),
                ];
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const AddEditStudents();
                      }));
                    },
                    label: Text(
                      'ADD STUDENTS',
                      style: TextStyle(
                          //fontFamily: 'FontFamily5',
                          // color: Colors.black,
                          fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: a,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    ),
                    icon: Row(
                      children: [
                        Icon(
                          Icons.add,
                          // color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.edit,
                          // color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return ViewStudentList();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                        //backgroundColor: a,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
                    label: Text(
                      'VIEW ALL STUDENTS',
                      style: TextStyle(
                          // fontFamily: 'FontFamily5',
                          // color: Colors.black,
                          fontSize: 20),
                    ),
                    icon: Icon(
                      Icons.view_list,
                      // color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: ElevatedButton.icon(
              //       onPressed: () {},
              //       style: ElevatedButton.styleFrom(
              //           padding:
              //               EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
              //       label: Text(
              //         'VIEW STUDENTS BY COURSE',
              //         style: TextStyle(
              //             //fontFamily: 'FontFamily5',
              //             fontSize: 20.0),
              //       ),
              //       icon: Icon(Icons.view_list),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setLogin() async {
    final shrd = await SharedPreferences.getInstance();
    await shrd.setBool('login', false);
    //return v;
  }

  void showLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
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
                setLogin();
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return LoginPage();
                }));
              },
            ),
          ],
        );
      },
    );
  }
}
