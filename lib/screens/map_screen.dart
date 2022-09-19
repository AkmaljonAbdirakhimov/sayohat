import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sayohat/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation placeLocation;
  final bool isSelecting;

  const MapScreen({
    Key? key,
    required this.placeLocation,
    required this.isSelecting,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _setLocation(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manzilni Belgilang'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () => Navigator.of(context).pop(
                        _pickedLocation,
                      ),
              icon: const Icon(
                Icons.check,
              ),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.placeLocation.latitude,
            widget.placeLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _setLocation : (LatLng location) {},
        markers: widget.isSelecting && _pickedLocation == null
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(widget.placeLocation.latitude,
                          widget.placeLocation.longitude),
                ),
              },
      ),
    );
  }
}
