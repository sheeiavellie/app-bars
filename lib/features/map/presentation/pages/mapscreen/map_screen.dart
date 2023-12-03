import 'dart:typed_data';
import 'dart:ui';

import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_bloc.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_event.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_state.dart';
import 'package:bars/features/map/presentation/widgets/animated_app_bar.dart';
import 'package:bars/features/map/presentation/widgets/bar_detailed_sheet/bar_detailed_sheet.dart';
import 'package:bars/features/map/presentation/widgets/bar_detailed_sheet/bar_detailed_sheet_state.dart';
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
  //Controllers
  late final YandexMapController _mapController;
  late final DraggableScrollableController _draggableScrollableController;

  //Values


  //States
  late final List<MapObject> _mapObjects;
  late BarDetailedSheetState _bottomSheetState;
  late BarEntity selectedBar;

  @override
  void initState() {
    super.initState();

    _draggableScrollableController = DraggableScrollableController();

    _mapObjects = [];
    _bottomSheetState = BarDetailedSheetState.normal;

    _draggableScrollableController.addListener(() {
      _bottomSheetAppBarExtension();
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
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          BlocProvider.of<RemoteBarsBloc>(context).add(const GetBars());
        },
      ),
    );
  }

  _buildAppBar() {
    return AnimatedAppBar(
      backgroundColor: Colors.white, 
      leading: Center(
        child: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.black,
            size: 28.0,
            semanticLabel: "Go back to map",
          ),
          onPressed: () {
            setState(() {
              _draggableScrollableController
                .animateTo(
                  BarDetailedSheet.initialChildSize,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear,
                );
            });
          }, 
        ),
      ),
      barDetailedSheetState: _bottomSheetState,
      duration: const Duration(
        milliseconds: 200,
      ),
    );
  }

  _buildBody() {
    return Stack(
      children: <Widget>[
        _buildMap(),
        _buildBottomSheet(),
      ],
    );
  }

  _buildMap() {
    return BlocListener<RemoteBarsBloc, RemoteBarsState>(
      listener: (context, state) async {
        if (state is RemoteBarsException) {

        }
        if (state is RemoteBarsDone) {
          Iterable<Future<MapObject>> mappedList = state.bars!
            .map<Future<PlacemarkMapObject>>((BarEntity i) async => 
              PlacemarkMapObject(
                mapId: MapObjectId(
                  i.id!.toString()
                ),
                point: Point(
                  latitude: i.geolocation!.lat, 
                  longitude: i.geolocation!.long
                ),              
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
              )
            )
            .toList();

          Future<List<MapObject>> futureList = Future.wait(mappedList);
          List<MapObject> result = await futureList;

          setState(() {
            _mapObjects
              ..clear()
              ..addAll(result);
          });
        }
      },
      child: YandexMap(
        onMapCreated: (controller) async {
          _mapController = controller;
        },
        mapObjects: _mapObjects,
        onCameraPositionChanged: (cameraPosition, reason, finished) async {

        },
      ),
    );
  }

  _buildBottomSheet() {
    return BarDetailedSheet(
      draggableScrollableController: _draggableScrollableController,
    );
  }
  
  _bottomSheetAppBarExtension() {
    final double appBarHeight = MediaQuery.of(context).size.height - 
      (MediaQuery.of(context).viewPadding.top + kToolbarHeight);
    final double currentBottomSheetHeight = _draggableScrollableController.pixels;

    if(currentBottomSheetHeight >= appBarHeight) {
      _setBottomSheetState(BarDetailedSheetState.expanded);
    } else {
      _setBottomSheetState(BarDetailedSheetState.normal);
    }
  }

  _setBottomSheetState(BarDetailedSheetState newState) {
    if(newState != _bottomSheetState) {
      setState(() => _bottomSheetState = newState);
    } 
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
