import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:user_location/user_location.dart';

class MapWidget extends StatefulWidget {
  MapWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapWidgetState();

}

class _MapWidgetState extends State<MapWidget> {
  final List<Marker> markers = <Marker>[];
  final MapController mapController = MapController();
  UserLocationOptions userLocationOptions;


  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
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
            subdomains: ['a', 'b', 'c']
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