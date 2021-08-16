import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/Model/movie_model.dart';
import 'package:movie_app/Screens/Movies/add_movie.dart';
import 'package:movie_app/Screens/Boarding/login_screen.dart';
import 'package:movie_app/Services/firebase_services.dart';
import 'package:movie_app/Shared/colors.dart';
import 'package:movie_app/Shared/components.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: false,
            pinned: true,
            floating: false,

            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Movie List",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ) //TextStyle
                    ), //Text
                background: Image.network(
                  "https://static.vecteezy.com/system/resources/previews/002/236/321/original/movie-trendy-banner-vector.jpg",
                  fit: BoxFit.cover,
                ) //Images.network
                ), //FlexibleSpaceBar
            expandedHeight: 230,
            backgroundColor: AppColor.primaryColor,

            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    FirebaseService().signOutFromGoogle().then((value) => {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()))
                        });
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: Hive.openBox<Movie>("movieBox"),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return ValueListenableBuilder(
                  valueListenable: Hive.box<Movie>('movieBox').listenable(),
                  builder: (context, Box<Movie> items, _) {
                    List<int> keys = items.keys.cast<int>().toList();
                    if (keys.length != 0) {
                      return ListView.separated(
                        separatorBuilder: (_, index) => Divider(),
                        itemCount: keys.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final int key = keys[index];
                          final Movie? data = items.get(key);
                          return Movietile(
                              movieName: data!.movieName,
                              movieDirector: data.movieDirector,
                              movieImage: data.movieImgUrl,
                              movieIndex: index,
                              movieKey: keys[index]);
                        },
                      );
                    } else {
                      return noMovieWidget();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddMovie()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget noMovieWidget() {
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.images,
            size: 40,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "No Movies Added Yet",
            style: GoogleFonts.montserrat(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddMovie()));
            },
            child: Text(
              "Add your first movie",
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
