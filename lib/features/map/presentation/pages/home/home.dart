import 'package:flutter/material.dart';
import 'package:bars/features/map/presentation/pages/mapscreen/map_screen.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return const MapScreen();
  }
}
