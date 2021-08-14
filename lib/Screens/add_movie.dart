import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/Model/movie_model.dart';
import 'package:movie_app/Shared/colors.dart';

class AddMovie extends StatelessWidget {
  AddMovie({Key? key}) : super(key: key);

  final TextEditingController _movieName = TextEditingController();
  final TextEditingController _movieDirector = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie List"),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 60),
            child: TextField(
              controller: _movieName,
              decoration: InputDecoration(hintText: "Movie Name"),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 60),
            child: TextField(
              controller: _movieDirector,
              decoration: InputDecoration(hintText: "Movie Director"),
            ),
          ),
          TextButton(
              onPressed: () async {
                Movie movie = Movie(
                    movieName: _movieName.text,
                    movieDirector: _movieDirector.text,
                    movieImgUrl:
                        "https://static.toiimg.com/photo/msid-61283343/61283343.jpg?130798");
                var box = await Hive.openBox<Movie>("movieBox");
                box.add(movie);
                // print(box.values.first.movieName);
              },
              child: Text("Add"))
        ],
      ),
    );
  }
}
