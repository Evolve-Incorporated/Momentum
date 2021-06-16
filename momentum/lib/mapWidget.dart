import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:user_location/user_location.dart';
import 'package:latlong/latlong.dart';
import 'package:dart_random_choice/dart_random_choice.dart';

class MapWidget extends StatefulWidget {
  MapWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapWidgetState();

}

class _MapWidgetState extends State<MapWidget> {
  List<Color> pinColors = [];
  final List<Marker> markers = <Marker>[];
  final List<LatLng> userPins = <LatLng>[];
  final List<Polyline> polylines = <Polyline>[];
  final MapController mapController = MapController();
  UserLocationOptions userLocationOptions;

  MapPosition _currentMapPosition;

  _MapWidgetState() {
    pinColors.addAll(Colors.primaries);
    pinColors.addAll(Colors.accents);
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

  void _addMarker(LatLng position) {
    setState(() {
      final color = randomChoice(pinColors);
      markers.add(
        Marker(
          point: position,
          height: 47.0,
          width: 47.0,
          builder: (context) => Container(
            padding: EdgeInsets.fromLTRB(7.5, 0, 7.5, 15),
            child: Icon(
              Icons.location_pin,
              size: 32.0,
              color: color,
            ),
          ),
        )
      );

      userPins.add(position);

      print("New marker at: $position");
      print("Current # of markers: ${userPins.length}");

      if (userPins.length < 2) {
        return;
      }

      final previousMarkerPosition = userPins.elementAt(userPins.length - 2);
      final polyline = Polyline(
        points: [previousMarkerPosition, position],
        strokeWidth: 3.0,
      );
      polylines.add(polyline);
    });
  }

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
        context: context,
        mapController: mapController,
        markers: markers,

        updateMapLocationOnPositionChange: false,
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
        onLongPress: _addMarker,
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
        PolylineLayerOptions(
          polylineCulling: true,
          polylines: polylines,
        ),
        MarkerLayerOptions(markers: markers),
        userLocationOptions,
      ],
      mapController: mapController,
    );
  }

}