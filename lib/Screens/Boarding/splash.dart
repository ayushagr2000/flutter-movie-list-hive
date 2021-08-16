import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/Screens/login_screen.dart';
import 'package:movie_app/Screens/view_movies.dart';
import 'package:movie_app/Services/firebase_services.dart';
import 'package:movie_app/Shared/colors.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  checkLogin() {
    Timer(Duration(seconds: 5), () {
      if (FirebaseService().isLoggedIn()) {
        debugPrint("User is already logged in");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MovieList()));
      } else {
        print("User is not logged in");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.primaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: 250,
              child: Lottie.asset('assets/lottie/movie_popcorn.json'),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Text(
                    "Movie App",
                    style: GoogleFonts.montserrat(
                      color: AppColor.primaryColor,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Made with Love\nusing Flutter & Hive",
                    style: GoogleFonts.montserrat(
                      color: AppColor.primaryColor,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Container(
            //   width: 220,
            //   // margin: EdgeInsets.symmetric(),
            //   child: LinearProgressIndicator(
            //     backgroundColor: Colors.greenAccent,
            //     valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
