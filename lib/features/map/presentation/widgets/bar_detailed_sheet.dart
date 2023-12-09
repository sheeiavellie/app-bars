import 'dart:developer';

import 'package:bars/core/constants/constants.dart';
import 'package:bars/features/map/presentation/bloc/remote/bar_detailed_sheet/bar_detailed_sheet_bloc.dart';
import 'package:bars/features/map/presentation/widgets/bar_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarDetailedSheet extends StatelessWidget {
  final DraggableScrollableController draggableScrollableController;

  static const initialChildSize = 0.4;
  static const minChildSize = 0.1;
  static const maxChildSize = 0.9;

  late final ChangeNotifierAdapter sheetReduceAdapter = ChangeNotifierAdapter(
    draggableScrollableController,
    () {
      const double animationStart = 0.25;
      final double fixedControllerSize = 
        (draggableScrollableController.size - BarDetailedSheet.minChildSize) * 
        1 / (animationStart - BarDetailedSheet.minChildSize);

      return draggableScrollableController.size > animationStart ? 1 : fixedControllerSize;
    }
  );  

  BarDetailedSheet({
    super.key, 
    required this.draggableScrollableController,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: DraggableScrollableSheet(
        controller: draggableScrollableController,
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        snap: true,
        snapSizes: const [minChildSize, initialChildSize, maxChildSize],
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
              children: [
                BlocBuilder<BarDetailedSheetBloc, BarDetailedSheetState>(
                  builder: (context, state) {
                    if(state is BarDetailedSheetLoading) {
                      return ListView(
                        controller: scrollController,
                        children: const [
                          Text("Loading")
                        ],
                      );
                    }
                    if(state is BarDetailedSheetDone) {
                      log("Ya prishel! ${state.bar!.id}");
                      return ListView(
                        controller: scrollController,
                        children: [
                          BarDetails(
                            bar: state.bar!, 
                            draggableScrollableController: draggableScrollableController, 
                            animationAdapter: sheetReduceAdapter
                          ),
                          Text(loremIpsum),
                          Text(loremIpsum),
                          Text(loremIpsum),
                          Text(loremIpsum),
                          Text(loremIpsum),
                          Text(loremIpsum),
                          Text(loremIpsum),
                        ],
                      );
                    }
                    if(state is BarDetailedSheetException) {
                      return ListView(
                        controller: scrollController,
                        children: const [
                          Text("Error")
                        ],
                      );
                    }
                    return ListView(controller: scrollController);
                  }
                ),
                _buildDragHandle(),
              ],
            ),
          );
        },
      ),
    );
  }

  _buildDragHandle() {
    return IgnorePointer(
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
            ),
          ],
        ),
      ),
    );
  }
}
  