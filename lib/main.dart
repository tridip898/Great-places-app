import 'package:flutter/material.dart';
import './provider/great_places.dart';
import './screen/add_place_screen.dart';
import 'package:provider/provider.dart';
import './screen/place_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>GreatPlacesProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes:{
            '/':(context)=>PlaceListScreen(),
            '/add-place':(context)=>AddPlaceScreen()
          }
      ),
    );
  }
}
