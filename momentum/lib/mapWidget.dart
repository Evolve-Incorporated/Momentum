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

  @override
  void dispose() {
    super.dispose();
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
        zoomToCurrentLocationOnLoad: false,
        verbose: false,

        onTapFAB: () {
          userLocationOptions.updateMapLocationOnPositionChange = true;
        },
        locationUpdateIntervalMs: 1000,

        moveToCurrentLocationFloatingActionButton: toCurrentLocationButton,
        fabWidth: 60,
        fabHeight: 60,
    );

    return FlutterMap(
      options: MapOptions(
        plugins: [
          UserLocationPlugin(),
        ]
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