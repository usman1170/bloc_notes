// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? image;
  final _picker = ImagePicker();
  bool spinner = false;
  Future<void> getImage() async {
    final newImage = await _picker.pickImage(source: ImageSource.camera);
    if (newImage != null) {
      image = File(newImage.path);
      setState(() {});
    } else {
      print("no Image ");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      spinner = true;
    });
    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var url = Uri.parse("https://fakestoreapi.com/products");
    var request = http.MultipartRequest("post", url);
    request.fields["title"] = "image status";
    var multiport = http.MultipartFile("image", stream, length);
    request.files.add(multiport);
    var res = await request.send();
    print(res.stream.toString());
    if (res.statusCode == 200) {
      setState(() {
        spinner = false;
      });
      print("Image uploaded");
    } else {
      setState(() {
        spinner = false;
      });
      print("Failed");
    }
    setState(() {
      spinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: spinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Image Upload"),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                height: 250,
                width: 300,
                child: image == null
                    ? const Icon(Icons.image)
                    : Image.file(
                        File(image!.path).absolute,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(
                height: 18,
              ),
              MaterialButton(
                color: Colors.cyan,
                onPressed: () {
                  getImage();
                },
                child: const Text("Pick Image"),
              ),
              const SizedBox(
                height: 12,
              ),
              MaterialButton(
                color: Colors.cyan,
                onPressed: () {
                  uploadImage();
                },
                child: const Text("Upload"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
