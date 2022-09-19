import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayohat/models/place.dart';
import 'package:sayohat/providers/places_provider.dart';
import 'package:sayohat/widgets/image_input.dart';
import 'package:sayohat/widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File? _savedImage;
  PlaceLocation? _placeLocation;
  String _title = '';
  final _formKey = GlobalKey<FormState>();

  void _takeSavedImage(savedImage) {
    _savedImage = savedImage as File;
  }

  void _takePickedLocation(double latitude, double longitude, String address) {
    _placeLocation = PlaceLocation(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate() &&
        _savedImage != null &&
        _placeLocation != null) {
      _formKey.currentState!.save();
      Provider.of<PlacesProvider>(context, listen: false)
          .addPlace(_title, _savedImage!, _placeLocation!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sayohat Joyini Qo\'shish'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Joy nomi',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos, joy nomini kiriting.';
                          }
                        },
                        onSaved: (value) {
                          _title = value!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ImageInput(_takeSavedImage),
                      const SizedBox(
                        height: 20,
                      ),
                      LocationInput(_takePickedLocation),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text('Qo\'shish'),
          ),
        ],
      ),
    );
  }
}
