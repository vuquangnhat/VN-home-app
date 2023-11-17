import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:osm_flutter_hooks/osm_flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final controller = MapController();
  bool isReady = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: OSMFlutter(
          onMapIsReady: (isReady)async {
            if(isReady) {
              await controller.currentLocation();
            }
          },
            controller: controller,
            osmOption: OSMOption(
              userTrackingOption: UserTrackingOption(
                enableTracking: true,
                unFollowUser: false,
              ),
              zoomOption: ZoomOption(
                initZoom: 8,
                minZoomLevel: 3,
                maxZoomLevel: 19,
                stepZoom: 1.0,
              ),
              
              userLocationMarker: UserLocationMaker(
                personMarker: MarkerIcon(
                  icon: Icon(
                    Icons.location_history_rounded,
                    color: Colors.black,
                    size: 48,
                  ),
                ),
                directionArrowMarker: MarkerIcon(
                  icon: Icon(
                    Icons.double_arrow,
                    size: 48,
                  ),
                ),
              ),
              roadConfiguration: RoadOption(
                roadColor: Colors.blueGrey,
              ),
              markerOption: MarkerOption(
                  defaultMarker: MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.black,
                  size: 56,
                ),
              )),
              
            )));
  }
}
