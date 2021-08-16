import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/Model/movie_model.dart';
import 'package:movie_app/Screens/edit_movie.dart';
import 'package:movie_app/Services/image_utils.dart';
import 'package:movie_app/Shared/colors.dart';

class CustomInput extends StatelessWidget {
  TextEditingController controller;
  String title;
  CustomInput(this.controller, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(6)),
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: TextFormField(
        controller: controller,
        // decoration: InputDecoration(),
        validator: (value) {
          if (value!.isEmpty) {
            return '$title cannot be left empty';
          }
        },

        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            hintText: title,
            hintStyle: GoogleFonts.montserrat(
                // color: Colors.grey.shade400,
                fontSize: 15,
                fontWeight: FontWeight.w400),
            border: InputBorder.none
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)
            // )
            ),
      ),
    );
  }
}

class Movietile extends StatelessWidget {
  final String movieName, movieDirector, movieImage;
  final int movieKey, movieIndex;
  Movietile(
      {required this.movieName,
      required this.movieDirector,
      required this.movieImage,
      required this.movieIndex,
      required this.movieKey});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 100,
                  width: 100,
                  child: imageFromBase64String(movieImage,
                      fitMethod: BoxFit.cover)),
              Container(
                width: MediaQuery.of(context).size.width - 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        movieName,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.montserrat(
                            fontSize: 20, color: Color(0xff095D9E)),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 140,
                      child: RichText(
                        overflow: TextOverflow.clip,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Director- ",
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff272932))),
                          TextSpan(
                              text: movieDirector,
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff272932)))
                        ]),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
      secondaryActions: [
        IconSlideAction(
          caption: 'Update',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditMovie(
                          movieName: movieName,
                          movieDirector: movieDirector,
                          movieImgByte: movieImage,
                          movieKey: movieKey,
                        )))
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            final box = Hive.box<Movie>('movieBox');
            box.deleteAt(movieIndex);
          },
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  dynamic ontap;
  String title;
  CustomButton(this.ontap, this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: GestureDetector(
        onTap: ontap,
        child: Card(
          color: AppColor.primaryColor,
          elevation: 2,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 18),
              )),
        ),
      ),
    );
  }
}
