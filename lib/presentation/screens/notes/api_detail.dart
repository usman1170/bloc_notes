import 'package:flutter/material.dart';
import 'package:zoom/data/models/image_model.dart';

class ApiDetailsScreen extends StatefulWidget {
  const ApiDetailsScreen({super.key, required this.imageModel});
  final ImageModel imageModel;

  @override
  State<ApiDetailsScreen> createState() => _ApiDetailsScreenState();
}

class _ApiDetailsScreenState extends State<ApiDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final data = widget.imageModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Column(
        children: [
          Image.network(data.url.toString()),
          const SizedBox(
            height: 12,
          ),
          Text(
            data.title.toString(),
          )
        ],
      ),
    );
  }
}
