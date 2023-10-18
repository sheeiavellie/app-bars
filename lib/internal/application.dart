import 'package:bars/config/theme/app_themes.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_bloc.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_event.dart';
import 'package:bars/internal/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:bars/presentation/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Application extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteBarsBloc>(
      create: (context) => sl()..add(const GetBars()),
      child: MaterialApp(
        // title: 'Yandex Map',
        theme: theme(),
        home: const Home(),
      ),
    );
  }
}
