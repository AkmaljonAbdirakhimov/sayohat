import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sayohat/helpers/location_helper.dart';
import 'package:sayohat/models/place.dart';
import 'package:sayohat/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function takePickedLocation;
  const LocationInput(this.takePickedLocation, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewLocationImage;

  Future<void> _getCurrentLocation() async {
    try {
      final _locationData = await Location().getLocation();

      _getLocationImage(
          LatLng(_locationData.latitude!, _locationData.longitude!));
    } catch (e) {
      print(e);
      return;
    }
  }

  void _getLocationImage(LatLng location) async {
    setState(() {
      _previewLocationImage = LocationHelper.getLocationImage(
          latitude: location.latitude, longtitude: location.longitude);
    });
    final String formattedAdress =
        await LocationHelper.getFormattedAddress(location);

    widget.takePickedLocation(
        location.latitude, location.longitude, formattedAdress);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: _previewLocationImage == null
              ? const Text('Manzil tanlanmadi.')
              : Image.network(
                  _previewLocationImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: _getCurrentLocation,
              label: const Text('Mening manzilim'),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.map),
              onPressed: () async {
                final selectedLocation =
                    await Navigator.of(context).push<LatLng>(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => MapScreen(
                      placeLocation: PlaceLocation(
                          latitude: 41.307741,
                          longitude: 69.239525,
                          address: 'Tashkent'),
                      isSelecting: true,
                    ),
                  ),
                );

                if (selectedLocation == null) {
                  return;
                }

                _getLocationImage(selectedLocation);
              },
              label: const Text('Xaritani ochish'),
            ),
          ],
        ),
      ],
    );
  }
}
