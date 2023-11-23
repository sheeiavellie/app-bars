import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bars/core/constants/constants.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_bloc.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_event.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_state.dart';
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
  late final DraggableScrollableController _draggableScrollableController;

  final List<MapObject> mapObjects = [];

  bool _isBarInfoSheetExtended = false;

  @override
  void initState() {
    super.initState();

    _draggableScrollableController = DraggableScrollableController();

    _draggableScrollableController.addListener(() {
      log("${_draggableScrollableController.pixelsToSize(_draggableScrollableController.pixels)}");

      log("${MediaQuery.of(context).size.height}");
      log("${_draggableScrollableController.pixels}");

      if(_draggableScrollableController.pixels == MediaQuery.of(context).size.height) {
      //if(MediaQuery.of(context).size.height - _draggableScrollableController.pixels == MediaQuery.of(context).padding.top + kToolbarHeight) {
        log("I'm full");
        setState(() {
          _isBarInfoSheetExtended = true;
        });
      } else {
        log("I'm not full");
        setState(() {
          _isBarInfoSheetExtended = false;          
        });
      }
    });


  }

  @override
  void dispose() {
    _mapController.dispose();
    _draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(_isBarInfoSheetExtended),
      body: Stack(
        children: <Widget>[
          _buildBody(),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: DraggableScrollableSheet(
              controller: _draggableScrollableController,
              initialChildSize: 0.4,
              minChildSize: 0.15,
              snap: true,
              snapSizes: const [0.15, 0.4, 0.9],
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Stack(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(                
                        child: ListView(
                          controller: scrollController,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                            Text(loremIpsum),
                          ],
                        )
                      ),
                      IgnorePointer(
                        child: SizedBox(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 30,
                                height: 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[350],
                                ),
                                //margin: EdgeInsets.only(top: 20, bottom: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          BlocProvider.of<RemoteBarsBloc>(context).add(const GetBars());
        },
      ),
    );
  }

  _buildAppBar(bool isBarInfoSheetExtended) {
    return AppBar(
      backgroundColor: isBarInfoSheetExtended ? Colors.red[200] : Colors.transparent,
      leading: Center(child: 
        isBarInfoSheetExtended ? const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
          size: 24.0,
          semanticLabel: "Go back to map",
        ) : const SizedBox.shrink(),
      ), 
      forceMaterialTransparency: !isBarInfoSheetExtended,
    );
  }

  _buildBody() {
    return BlocListener<RemoteBarsBloc, RemoteBarsState>(
      listener: (context, state) async {
        if (state is RemoteBarsException) {

        }
        if (state is RemoteBarsDone) {
          Iterable<Future<MapObject>> mappedList = state.bars!
          .map<Future<PlacemarkMapObject>>((BarEntity i) async => PlacemarkMapObject(
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
            onTap: (mapObject, point) {

            },
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
