import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/Model/movie_model.dart';
import 'package:movie_app/Services/image_utils.dart';
import 'package:movie_app/Shared/colors.dart';
import 'package:movie_app/Shared/components.dart';

class AddMovie extends StatefulWidget {
  AddMovie({Key? key}) : super(key: key);

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final TextEditingController _movieName = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TextEditingController _movieDirector = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String imgBase64 = "";

  pickImage() async {
    print("object");
    final ImagePicker _picker = ImagePicker();
    // Pick an image

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    File file = File(image!.path);
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: file.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Movie poster',
            toolbarColor: AppColor.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    Uint8List bytes;
    bytes = croppedFile!.readAsBytesSync();

    print("byte is " + bytes.toString());
    print("base 64 is " + base64String(bytes));
    setState(() {
      imgBase64 = base64String(bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Movie List"),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print("object");
                pickImage();
              },
              child: imgBase64 == ""
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // border: Border.all(width: 1).
                          ),
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo),
                              Text("Add A Photo",
                                  style: GoogleFonts.montserrat()),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          // color: Colors.red,
                          child: imageFromBase64String(imgBase64),
                        ),
                      ),
                    ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 350,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomInput(_movieName, "Movie Name"),
                      CustomInput(_movieDirector, "Movie Director"),
                      Spacer(),
                      CustomButton(() async {
                        if (imgBase64 == "") {
                          showSnackMessage("Pick Image", _scaffoldKey);
                        } else {
                          if (_formKey.currentState!.validate()) {
                            showSnackMessage("Movie added", _scaffoldKey);
                            Timer(Duration(seconds: 1), () async {
                              Movie movie = Movie(
                                  movieName: _movieName.text,
                                  movieDirector: _movieDirector.text,
                                  movieImgUrl: imgBase64);
                              var box = await Hive.openBox<Movie>("movieBox");
                              box.add(movie);
                              Navigator.pop(context);
                              print("POP");
                              // print(box.values.first.movieName);
                            });
                          }
                        }
                      }, "Add Movie"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showSnackMessage(String message, _scaffoldKey) {
    return _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
