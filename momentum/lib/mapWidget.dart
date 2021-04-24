import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:user_location/user_location.dart';
import 'package:latlong/latlong.dart';

class MapWidget extends StatefulWidget {
  MapWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapWidgetState();

}

class _MapWidgetState extends State<MapWidget> {
  final List<Marker> markers = <Marker>[];
  final MapController mapController = MapController();
  StreamController<LatLng> markerLocationStream = StreamController();
  UserLocationOptions userLocationOptions;

  MapPosition _currentMapPosition;

  @override
  void dispose() {
    super.dispose();
    markerLocationStream.close();
    markerLocationStream.close();
  }

  final Container toCurrentLocationButton = Container(
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(40.0),
      boxShadow: [
        BoxShadow(color: Colors.grey, blurRadius: 20.0),
      ],
    ),
    child: Icon(
      Icons.my_location,
      color: Colors.white,
      size: 32.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    markerLocationStream.stream.listen((onData) {
      // print(onData.latitude);
    });

    userLocationOptions = UserLocationOptions(
        context: context,
        mapController: mapController,
        markers: markers,

        updateMapLocationOnPositionChange: true,
        showMoveToCurrentLocationFloatingActionButton: true,
        zoomToCurrentLocationOnLoad: true,
        verbose: false,

        onTapFAB: () {
          userLocationOptions.updateMapLocationOnPositionChange = true;
        },
        locationUpdateIntervalMs: 1000,

        moveToCurrentLocationFloatingActionButton: toCurrentLocationButton,
        fabWidth: 60,
        fabHeight: 60,
        defaultZoom: 13.0,
    );

    return FlutterMap(
      options: MapOptions(
        plugins: [
          UserLocationPlugin(),
        ],
        zoom: 13.0,
        onPositionChanged: (position, hasGesture) {
          if (_currentMapPosition != null && _currentMapPosition.center != position.center) {
            print('Map has been moved: free camera view!');
            userLocationOptions.updateMapLocationOnPositionChange = false;
          }

          _currentMapPosition = position;
        },
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: markers
        ),
        userLocationOptions,
      ],
      mapController: mapController,
    );
  }

}