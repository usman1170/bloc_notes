import 'package:flutter/material.dart';
import 'package:zoom/data/models/user_model.dart';

class ApiDetailsScreen extends StatefulWidget {
  const ApiDetailsScreen({super.key, required this.imageModel});
  final UserModel imageModel;

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.network(data.url.toString()),
            const SizedBox(
              height: 12,
            ),
            Text(data.name.toString()),
            const SizedBox(
              height: 12,
            ),
            Text(data.email.toString()),
            const SizedBox(
              height: 12,
            ),
            Text(data.address!.city.toString()),

            const SizedBox(
              height: 12,
            ),
            Text(data.address!.suite.toString()),
            const SizedBox(
              height: 12,
            ),
            Text(
                "${data.address!.geo!.lat.toString()}, ${data.address!.geo!.lng.toString()}"),
          ],
        ),
      ),
    );
  }
}
