import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Location',
          style: TextStyle(color: Colors.white),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 32,
          fontFamily: 'Baskerville',
        ),
        centerTitle: false,
        backgroundColor: Colors.teal.shade600,
      ),
      body: Center(
        child: OpenStreetMapSearchAndPick(
          // Adjust based on the parameter's actual name
          buttonColor: Colors.blue,
          buttonText: 'Set Current Location',
          onPicked: (pickedData) {
            // Pass the selected latitude and longitude back to the previous screen
            Navigator.pop(
                context, pickedData.latLong);
          },
        ),
      ),
    );
  }
}
