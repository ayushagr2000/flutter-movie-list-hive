import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/Model/movie_model.dart';
import 'package:movie_app/Screens/add_movie.dart';
import 'package:movie_app/Shared/colors.dart';

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
      appBar: AppBar(
        title: Text("Movie List"),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Hive.openBox<Movie>("movieBox"),
        builder: (context, snapshot) {
          return ValueListenableBuilder(
            valueListenable: Hive.box<Movie>('movieBox').listenable(),
            builder: (context, Box<Movie> items, _) {
              List<int> keys = items.keys.cast<int>().toList();
              return ListView.separated(
                separatorBuilder: (_, index) => Divider(),
                itemCount: keys.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  final int key = keys[index];
                  final Movie? data = items.get(key);
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
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              height: 85,
                              width: 60,
                              child: Image.network(
                                data!.movieImgUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.movieName,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20, color: Color(0xff095D9E)),
                                ),
                                Row(
                                  children: [
                                    Text("Director- ",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff272932))),
                                    Text(data.movieDirector,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xff272932))),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )

                        //  ListTile(
                        // title: Text(
                        //   data!.movieName,
                        //   style: GoogleFonts.montserrat(
                        //       fontSize: 20, color: Color(0xff095D9E)),
                        // ),
                        // subtitle: Row(
                        //   children: [
                        //     Text("Director- ",
                        //         style: GoogleFonts.montserrat(
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.w500,
                        //             color: Color(0xff272932))),
                        //     Text(data.movieDirector,
                        //         style: GoogleFonts.montserrat(
                        //             fontSize: 18,
                        //             fontWeight: FontWeight.w300,
                        //             color: Color(0xff272932))),
                        //   ],
                        // ),
                        // leading: Container(
                        //   height: 85,
                        //   width: 60,
                        //   child: Image.network(
                        //     data.movieImgUrl,
                        //     fit: BoxFit.cover,
                        //   ),
                        // )
                        // ),
                        ),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Update',
                        color: Colors.blue,
                        icon: Icons.edit,
                        onTap: () => {},
                      ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          final box = Hive.box<Movie>('movieBox');
                          box.deleteAt(index);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
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
}
