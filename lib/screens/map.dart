import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location = const PlaceLocation(
          latitude: 37.422131, longitude: -122.084801, address: ''),
      this.isLocation = true});

  final PlaceLocation location;
  final bool isLocation;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {

  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isLocation ? 'Pick a location' : 'Your Location'),
        actions: [
          if (widget.isLocation)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isLocation ? null : (position){
          _pickedLocation = position;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isLocation == true) ? {} : {
          Marker(
              markerId: const MarkerId('m1'),
              position: _pickedLocation != null ? _pickedLocation! :
                  LatLng(widget.location.latitude, widget.location.longitude))
        },
      ),
    );
  }
}
