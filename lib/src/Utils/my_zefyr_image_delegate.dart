import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zefyr/zefyr.dart';

class MyAppZefyrImageDelegate implements ZefyrImageDelegate<ImageSource> {
  //For device upload to server storage
//  final MyFileStorage storage;
//  MyAppZefyrImageDelegate(this.storage);

  @override
  Future<String> pickImage(ImageSource source) async {
    print('pickImage init');
    final file = await ImagePicker.pickImage(source: source);
    if (file == null) return null;
    // We simply return the absolute path to selected file.
    print('paht: ${file.uri.toString()}');
    return file.uri.toString();
  }

  //For server
//  @override
//  Future<String> pickImage(ImageSource source) async {
//    final file = await ImagePicker.pickImage(source: source);
//    if (file == null) return null;
//    // Use my storage service to upload selected file. The uploadImage method
//    // returns unique ID of newly uploaded image on my server.
//    final String imageId = await storage.uploadImage(file);
//    return imageId;
//  }

  @override
  Widget buildImage(BuildContext context, String key) {
    final file = File.fromUri(Uri.parse(key));

    /// Create standard [FileImage] provider. If [key] was an HTTP link
    /// we could use [NetworkImage] instead.
    final image = FileImage(file);
    return Image(image: image);
  }

  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;
}