import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../models/great_place_model.dart';
import 'dart:io';
import '../service/db_service.dart';

class GreatPlacesProvider with ChangeNotifier{
  List<GreatPlaceModel> _places=[];

  List<GreatPlaceModel> get places{
    return [..._places];
  }

  void addPlace(String pickedTitle, File pickedImage){
    final newPlace=GreatPlaceModel(id: DateTime.now().toString(), title: pickedTitle, imageUrl: pickedImage, location: null.toString());
    _places.add(newPlace);
    notifyListeners();
    SQLHelper.createItems({
      'id':newPlace.id,
      'title':newPlace.title,
      'image':newPlace.imageUrl
    });
  }

  Future<void> fetchPlaces() async{
    final dbList = await SQLHelper.getItems();
    _places=dbList.map((place) => GreatPlaceModel(id: place['id'], title: place['title'], imageUrl: File(place['image']), location: '')).toList();
    notifyListeners();
  }
}