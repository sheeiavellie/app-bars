import 'package:bars/config/styles/text_styles/text_styles.dart';
import 'package:bars/core/constants/constants.dart';
import 'package:flutter/material.dart';

class BarDetailedSheet extends StatelessWidget {
  final DraggableScrollableController draggableScrollableController;  

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
        initialChildSize: 0.4,
        minChildSize: 0.15,
        maxChildSize: 0.9,
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
                          child: RichText(
                            text: TextSpan(
                              text: "Таинственный необъяснимый Белградский турничок ",
                              
                              style: TextStyles.barInfoSheetHeaderStyle,
                              children: <TextSpan>[
                                TextSpan(
                                  text: "🛸",
                                  style: TextStyles.emojiInText(fontSize: 24),
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
                      ),
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
