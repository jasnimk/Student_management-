import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management/screens/welcome_screen.dart';
// import 'package:student_management/welcome_screen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final user = 'admin';
  final pass = '123';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: usernamecontroller,
                  style: TextStyle(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 8, 83, 121),
                      labelText: 'Enter Username!'),
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                ),
                TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  style: TextStyle(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color.fromARGB(255, 8, 83, 121),
                      labelText: 'Enter Password!'),
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                ),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () {
                          if (usernamecontroller.text == user &&
                              passwordcontroller.text == pass) {
                            setLogin();
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return WelcomeScreen();
                            }));
                          } else {
                            showError();
                          }
                        },
                        child: Text('LogIn'))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showError() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text('Incorrect Details!'),
          );
        });
  }

  Future<void> setLogin() async {
    final shrd = await SharedPreferences.getInstance();
    await shrd.setBool('login', true);
    // return v;
  }
}
