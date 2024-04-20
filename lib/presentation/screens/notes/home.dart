import 'package:flutter/material.dart';
import 'package:zoom/data/services/apis.dart';
import 'package:zoom/presentation/screens/notes/api_detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Apis apis = Apis();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: apis.getusers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                final newData = data[index];
                // print(newData.email);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ApiDetailsScreen(imageModel: newData),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      // leading: Container(
                      //   height: 55,
                      //   width: 55,
                      //   decoration: const BoxDecoration(shape: BoxShape.circle),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(50),
                      //     child: Image.network(
                      //       newData.url.toString(),
                      //     ),
                      //   ),
                      // ),
                      title: Text(newData.name.toString()),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${newData.email}"),
                          Text("City = ${newData.address!.city}"),
                          Text("Street = ${newData.address!.street}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text(snapshot.error.toString()));
          }
        },
      ),
    );
  }
}
