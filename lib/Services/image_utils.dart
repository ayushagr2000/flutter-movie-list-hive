import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

Image imageFromBase64String(String base64String,
    {BoxFit fitMethod = BoxFit.contain}) {
  return Image.memory(
    base64Decode(base64String),
    fit: fitMethod,
  );
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}
