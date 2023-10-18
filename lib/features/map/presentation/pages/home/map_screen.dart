import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_bloc.dart';
import 'package:bars/features/map/presentation/bloc/bar/remote/remote_bar_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: const Text(
        'Workout places',
        style: TextStyle(
          color: Colors.black,
          // fontFamily: 'Soledago',
          // fontSize: 35,
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteBarsBloc, RemoteBarsState> (
      builder: (_, state) {
        if (state is RemoteBarsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if(state is RemoteBarsException) {
          return const Center(child: Icon(Icons.refresh));
        }
        if(state is RemoteBarsDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('amogus $index'),
              );
            },
            itemCount: state.bars!.length,
          );
        }
        return const SizedBox();
      },
    );
  }
}
