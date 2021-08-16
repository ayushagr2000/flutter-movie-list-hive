import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/Screens/view_movies.dart';
import 'package:movie_app/Services/firebase_services.dart';
import 'package:movie_app/Shared/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 250,
              width: 250,
              child: Lottie.asset('assets/lottie/login_panel.json'),
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseService().signInwithGoogle();
                      if (FirebaseService().isLoggedIn()) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieList()));
                      } else {
                        print("logged out");
                      }
                    },
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Lottie.network(
                                "https://assets9.lottiefiles.com/private_files/lf30_29gwi53x.json"),
                          ),
                          Text("Login With Google",
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w500)),
                          // Icon(FontAwesomeIcons.google
                        ],
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MovieList()));
                  },
                  child: Text(
                    "Skip in Release Apk",
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
