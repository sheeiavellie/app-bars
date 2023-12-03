import 'package:bars/config/styles/text_styles/text_styles.dart';
import 'package:bars/features/map/domain/entities/bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BarDetails extends StatelessWidget {
  final BarEntity bar;
  final DraggableScrollableController draggableScrollableController;
  final ChangeNotifierAdapter sheetReduceAdapter;

  const BarDetails({
    super.key, 
    required this.bar, 
    required this.draggableScrollableController, 
    required this.sheetReduceAdapter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
        _buildImageAndCoordinates(),
      ],
    );
  }

  _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
      ),
      child: Container(
        height: 50,
        child: Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            textAlign: TextAlign.start,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
              text: "Таинственный абдактивный Белградский Турничек" " ",
              style: TextStyles.barInfoSheetHeaderStyle(fontSize: 18),
              children: <TextSpan>[
                TextSpan(
                  text: "🛸",
                  style: TextStyles.emojiInText(fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildImageAndCoordinates() {
    return Padding(
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
        adapter: sheetReduceAdapter,
      )
      .scaleXY()
      .then()
      .fade(begin: 0, end: 3);
  }
}