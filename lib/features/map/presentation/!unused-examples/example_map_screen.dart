import 'dart:async';
import 'package:bars/features/map/data/services/location_service.dart';
import 'package:bars/features/map/domain/app_lat_long.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  final Completer mapControllerCompleter = Completer<YandexMapController>();  
  YandexMap map = YandexMap();

  final List<MapObject> mapObjects = [];

  final MapObjectId mapObjectId = const MapObjectId('normal_icon_placemark');

  int i = 0;

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amogus'),
      ),
      body: YandexMap(
        onMapCreated: (controller) {
          mapControllerCompleter.complete(controller);
        },
        mapObjects: mapObjects,
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async {

      //     print("pressed :)" + mapObjects.length.toString());

      //     final mapObject = PlacemarkMapObject(
      //       mapId: MapObjectId('2'),
      //       point: const Point(latitude: 59.945933, longitude: 30.320045),
      //       onTap: (PlacemarkMapObject self, Point point) => print('Tapped me at $point'),
      //       opacity: 0.7,
      //       direction: 90,
      //       isDraggable: true,
      //       onDragStart: (_) => print('Drag start'),
      //       onDrag: (_, Point point) => print('Drag at point $point'),
      //       onDragEnd: (_) => print('Drag end'),
      //       icon: PlacemarkIcon.single(PlacemarkIconStyle(
      //         image: BitmapDescriptor.fromAssetImage('lib/assets/place.png'),
      //         rotationType: RotationType.rotate
      //       )),
      //       text: const PlacemarkText(
      //         text: 'Point',
      //         style: PlacemarkTextStyle(
      //           placement: TextStylePlacement.top,
      //           color: Colors.amber,
      //           outlineColor: Colors.black
      //         )
      //       )
      //     );
          
      //     setState(() {
      //       mapObjects.add(mapObject);
      //     });
      //   }
      // ),
    );
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = StPetersburgLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch(_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(
    AppLatLong appLatLong,
  ) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
            ),
          zoom: 12,
        ),
      ),
    );
  }
}

