import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systempath;

class ImageInput extends StatefulWidget {
  final Function takeSavedImage;

  const ImageInput(this.takeSavedImage, {Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final photo = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (photo != null) {
      setState(() {
        _imageFile = File(photo.path);
      });

      final pathProvider = await systempath.getApplicationDocumentsDirectory();
      final fileName = path.basename(photo.path);
      final savedImage = await _imageFile!
          .copy('${pathProvider.path}/$fileName'); // documents/rasm.jpg;

      widget.takeSavedImage(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text('Rasm Yo\'q'),
        ),
        TextButton.icon(
          onPressed: _takePicture,
          icon: const Icon(Icons.camera),
          label: const Text('Rasm Olish'),
        ),
      ],
    );
  }
}
