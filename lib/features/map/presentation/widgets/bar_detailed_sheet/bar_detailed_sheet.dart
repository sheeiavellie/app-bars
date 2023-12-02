import 'dart:developer';

import 'package:bars/config/styles/text_styles/text_styles.dart';
import 'package:bars/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BarDetailedSheet extends StatelessWidget {
  final DraggableScrollableController draggableScrollableController;

  static const initialChildSize = 0.4;
  static const minChildSize = 0.1;
  static const maxChildSize = 0.9;

  const BarDetailedSheet({
    super.key, 
    required this.draggableScrollableController
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
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                        ),
                        child: Container(
                          height: 50,
                          color: Colors.amber,
                          child: RichText(
                            textAlign: TextAlign.left,
                            softWrap: true,                            
                            text: TextSpan(
                              text: "TaumatawhakatangihangakoauauoTamateaturipukakapikimaungahoronukupokaiwhenuakitanatahu ",                              
                              style: TextStyles.barInfoSheetHeaderStyle(fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "🛸",
                                  style: TextStyles.emojiInText(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: 12,
                          right: 12,
                          bottom: 12,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 240,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  "assets/test/534-1000x830.jpg",
                                  fit: BoxFit.fitWidth,
                                  width: double.infinity,
                                  height: double.infinity,
                                  alignment: Alignment.topCenter,
                                ),
                              ),                                    
                            ),
                            const SizedBox(height: 6,),
                            Row(
                              children: [
                                Icon(
                                  Icons.map_outlined,
                                ),
                                Text(
                                  "12.34567, 12.34567"
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                        .animate(
                          adapter: ChangeNotifierAdapter(
                            draggableScrollableController,
                            () {
                              const double animationStart = 0.25;
                              final double fixedControllerSize = 
                                (draggableScrollableController.size - BarDetailedSheet.minChildSize) * 
                                1 / (animationStart - BarDetailedSheet.minChildSize);

                              return draggableScrollableController.size > animationStart ? 1 : fixedControllerSize;
                            }
                          )
                        )
                        .scaleXY()
                        .then()
                        .fade(begin: 0, end: 3),
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
    );
  }
}
