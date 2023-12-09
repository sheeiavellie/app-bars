import 'package:bars/config/theme/app_themes.dart';
import 'package:bars/features/map/presentation/bloc/remote/bar_map_objects/bar_map_objects_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bars/features/map/presentation/pages/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BarMapObjectsBloc>(),
      child: MaterialApp(
        // title: 'Yandex Map',
        theme: theme(),
        home: const Home(),
      ),
    );
  }
}
