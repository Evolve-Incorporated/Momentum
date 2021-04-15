import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

class MapWidget extends StatefulWidget {
  MapWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapWidgetState();

}

class _MapWidgetState extends State<MapWidget> {
  _MapWidgetState() :
      markers = <Marker>[];

  final List<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(

      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
        ),
        MarkerLayerOptions(
          markers: markers
        )
      ],
    );
  }

}