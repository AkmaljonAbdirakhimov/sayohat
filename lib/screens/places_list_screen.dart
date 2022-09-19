import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayohat/providers/places_provider.dart';
import 'package:sayohat/screens/add_place_screen.dart';
import 'package:sayohat/screens/place_details_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sayohat'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
          future:
              Provider.of<PlacesProvider>(context, listen: false).getPlaces(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<PlacesProvider>(
              builder: (ctx, placeProvider, child) {
                if (placeProvider.list.isNotEmpty) {
                  return ListView.builder(
                    itemCount: placeProvider.list.length,
                    itemBuilder: (c, i) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          placeProvider.list[i].image,
                        ),
                      ),
                      title: Text(
                        placeProvider.list[i].title,
                      ),
                      subtitle: Text(placeProvider.list[i].location.address),
                      onTap: () {
                        // detail screen
                        Navigator.of(context).pushNamed(
                          PlaceDetailsScreen.routeName,
                          arguments: placeProvider.list[i].id,
                        );
                      },
                    ),
                  );
                } else {
                  return child!;
                }
              },
              child: const Center(
                child: Text('Sayohat joylari mavjud emas, iltimos qo\'shing!'),
              ),
            );
          }),
    );
  }
}
