import 'package:flutter/material.dart';
import 'package:great_places_app/widget/image_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../provider/great_places.dart';
import '../widget/location_input.dart';


class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController=TextEditingController();
  File? _pickedImage;
  void _selectImage(File pickedImage){
    _pickedImage=pickedImage;
  }
  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage == null){
      return;
    }
    Provider.of<GreatPlacesProvider>(context,listen: false).addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          title: const Text("Add a New Place"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: "Title"
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ImageInput(onSelectImage: _selectImage),
                      SizedBox(
                        height: 10,
                      ),
                      LocationInput()
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
                onPressed: _savePlace,
                icon: const Icon(Icons.add),
                label: const Text("Add Place"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                elevation: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
