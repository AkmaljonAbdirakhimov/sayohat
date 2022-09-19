import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayohat/providers/places_provider.dart';
import 'package:sayohat/screens/add_place_screen.dart';
import 'package:sayohat/screens/place_details_screen.dart';
import 'package:sayohat/screens/places_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlacesProvider(),
      child: MaterialApp(
        title: 'Sayohat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (ctx) => const PlaceDetailsScreen(),
        },
      ),
    );
  }
}
