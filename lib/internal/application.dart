import 'package:bars/config/theme/app_themes.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bars/features/map/presentation/pages/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RemoteBarsBloc>(),
      child: MaterialApp(
        // title: 'Yandex Map',
        theme: theme(),
        home: const Home(),
      ),
    );
  }
}
