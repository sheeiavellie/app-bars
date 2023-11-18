import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bars/core/constants/constants.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_bloc.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_event.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../../domain/entities/bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final YandexMapController _mapController;
  final List<MapObject> mapObjects = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          BlocProvider.of<RemoteBarsBloc>(context).add(const GetBarByID(5));
        },
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        'Workout places',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: Color.fromRGBO(234, 221, 255, 1),
    );
  }

  _buildBody() {
    return BlocListener<RemoteBarsBloc, RemoteBarsState>(
      listener: (context, state) async {
        if (state is RemoteBarsException) {

        }
        if (state is RemoteBarsDone) {
          Iterable<Future<MapObject>> mappedList = state.bars!
          .map<Future<PlacemarkMapObject>>((BarEntity i) async => await PlacemarkMapObject(
            mapId: MapObjectId(i.id!.toString()),
            point: Point(latitude: i.geolocation!.lat, longitude: i.geolocation!.long),
            
            icon: PlacemarkIcon.composite([
              PlacemarkCompositeIconItem(
                name: 'emoji',
                style: PlacemarkIconStyle(
                  image: BitmapDescriptor.fromBytes(await _rawPlacemarkImage(i.char_emoji!, 100)),
                  anchor: const Offset(0.5, 0.5),
                  scale: 1,
                )
              ),
            ]),
            opacity: 1,
            onTap: (mapObject, point) => showModalBottomSheet<void>(
              context: context,
              builder: (context) => _buildBottomSheet(i),
              showDragHandle: true,
              enableDrag: true,
              isScrollControlled: true,
              barrierColor: Colors.transparent,              
              backgroundColor: Color.fromRGBO(234, 221, 255, 1),              
            ),
          )).toList();

          Future<List<MapObject>> futureList = Future.wait(mappedList);
          List<MapObject> result = await futureList;

          setState(() {
            mapObjects
            ..clear()
            ..addAll(result);
          });
        }
      },
      child: _buildMap(),
    );
  }

  _buildMap() {
    return YandexMap(
      onMapCreated: (controller) async {
        _mapController = controller;
      },
      mapObjects: mapObjects,
      onCameraPositionChanged: (cameraPosition, reason, finished) async {
        //final vr = await _mapController.getVisibleRegion();
        // log("lat: ${cameraPosition.target.latitude}");
        // log("long: ${cameraPosition.target.longitude}");
        // log("zoom: ${cameraPosition.zoom}");
        // log("------------------------");
        // log("top left: ${vr.topLeft.latitude} ${vr.topLeft.longitude}");
        // log("bottom right: ${vr.bottomRight.latitude} ${vr.bottomRight.longitude}");
        // log("bottom left: ${vr.bottomLeft.latitude} ${vr.bottomLeft.longitude}");
        // log("top right: ${vr.topRight.latitude} ${vr.topRight.longitude}");
        // log("------------------------");
      },
    );
  }

  Widget _buildBottomSheet(BarEntity bar) {
    return DraggableScrollableSheet(
      builder:(context, scrollController) => Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('${bar.name}${bar.char_emoji}'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Text(loremIpsum),
            Text(loremIpsum),
            Text(loremIpsum),
            Text(loremIpsum),
            Text(loremIpsum),
          ],
        ),
      ),
    );
  } 

  Future<Uint8List> _rawPlacemarkImage(String emoji, double fontSize) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final TextSpan span = TextSpan(
      text: emoji,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontFamily: "AppleColorEmoji"
        ),
      );
    final TextPainter tp = TextPainter(
      text: span, 
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    );

    tp.layout();

    final textOffset = Offset(
      (tp.width) * 0,
      (tp.height) * 0,
    );

    tp.paint(canvas, textOffset);

    final image = await recorder.endRecording().toImage(tp.width.toInt(), tp.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }
}

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
