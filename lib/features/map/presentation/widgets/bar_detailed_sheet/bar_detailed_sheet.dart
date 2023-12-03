import 'package:bars/core/constants/constants.dart';
import 'package:bars/features/map/domain/entities/bar.dart';
import 'package:bars/features/map/presentation/widgets/bar_detailed_sheet/bar_detailed_sheet_content/bar_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BarDetailedSheet extends StatelessWidget {
  final DraggableScrollableController draggableScrollableController; 
  final BarEntity? bar;

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
    this.bar, 
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
                Container(                
                  child: ListView(
                    controller: scrollController,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      _buildContent(),
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

  _buildContent() {
    if(bar != null) {
      return BarDetails(
        bar: bar!, 
        draggableScrollableController: draggableScrollableController, 
        sheetReduceAdapter: sheetReduceAdapter
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
  