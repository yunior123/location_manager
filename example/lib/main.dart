import 'package:flutter/material.dart';
import 'package:location_manager/models/location_model.dart';
import 'package:location_manager_example/locator_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final locationHandler = LocationHandler();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example Location Manager'),
        ),
        body: StreamBuilder<LocationModel>(
          stream: locationHandler.stream,
          builder: (context, AsyncSnapshot<LocationModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator.adaptive();
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (!snapshot.hasData) {
              return const Text("No data");
            }
            final item = snapshot.data!;

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Table(
                  children: [
                    TableRow(children: [
                      const Text("Latitude"),
                      Text(item.latitude.toString()),
                    ]),
                    TableRow(children: [
                      const Text("Longitude"),
                      Text(item.longitude.toString()),
                    ]),
                    TableRow(children: [
                      const Text("Accuracy"),
                      Text(item.accuracy.toString()),
                    ]),
                    TableRow(children: [
                      const Text("Altitude"),
                      Text(item.altitude.toString()),
                    ]),
                    TableRow(children: [
                      const Text("Speed"),
                      Text(item.speed.toString()),
                    ]),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
