import 'package:hive/hive.dart';
part 'movie_model.g.dart';

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  late String movieName;

  @HiveField(1)
  late String movieDirector;

  @HiveField(2)
  late String movieImgUrl;

  Movie(
      {required this.movieName,
      required this.movieDirector,
      required this.movieImgUrl});
}
