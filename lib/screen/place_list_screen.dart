import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/great_places.dart';

class PlaceListScreen extends StatefulWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  State<PlaceListScreen> createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              elevation: 0,
              title: const Text(
                "Your Places",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/add-place');
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            body: FutureBuilder(
                future: Provider.of<GreatPlacesProvider>(context,listen: false).fetchPlaces(),
                builder: (context, snapshot) => snapshot.connectionState==ConnectionState.waiting? Center(child: CircularProgressIndicator(),) : Consumer<GreatPlacesProvider>(
                      child: const Center(
                        child: Text("Got no places yet, add some places!"),
                      ),
                      builder: (context, greatPlaces, ch) =>
                          greatPlaces.places.length <= 0
                              ? ch as Widget
                              : ListView.builder(
                                  itemCount: greatPlaces.places.length,
                                  itemBuilder: (_, index) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: FileImage(
                                            greatPlaces.places[index].imageUrl),
                                      ),
                                      title: Text(
                                        greatPlaces.places[index].title,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      //subtitle: Text(greatPlaces.places[index].location as String,style: const TextStyle(fontSize: 17),),
                                    );
                                  },
                                ),
                    ))));
  }
}
