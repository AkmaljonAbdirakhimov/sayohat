import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayohat/providers/places_provider.dart';
import 'package:sayohat/screens/map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/details';
  const PlaceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final place = Provider.of<PlacesProvider>(context).getById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            place.location.address,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    placeLocation: place.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: const Text('Manzilni xaritada ko\'rish'),
          )
        ],
      ),
    );
  }
}
