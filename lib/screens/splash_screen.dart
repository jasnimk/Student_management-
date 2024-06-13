// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Splash extends StatefulWidget {
//   const Splash({Key? key}) : super(key: key);

//   @override
//   _SplashState createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   @override
//   void initState() {
//     super.initState();
//     checkLoginAndNavigate();
//   }

//   Future<void> checkLoginAndNavigate() async {
//     final shr = await SharedPreferences.getInstance();
//     final userLoggedIn = shr.getBool('login');
//     print(userLoggedIn);
//     if (userLoggedIn == true) {
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Placeholder widget until navigation is performed
//     return Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLoginAndNavigate();
    });
  }

  Future<void> checkLoginAndNavigate() async {
    await Future.delayed(Duration(seconds: 6));
    print(
        'Checking login status...'); // Optional delay for splash screen effect
    final shr = await SharedPreferences.getInstance();
    final userLoggedIn = shr.getBool('login') ?? false;

    print('User logged in status: $userLoggedIn'); // Debug log

    if (userLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
