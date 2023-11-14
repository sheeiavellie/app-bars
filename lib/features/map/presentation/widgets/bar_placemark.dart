import 'package:flutter/material.dart';

class BarPlacemark extends StatelessWidget {
  final String characteristicEmoji;
  const BarPlacemark({
    super.key,
    required this.characteristicEmoji,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const Icon(
              Icons.place,
              color: Colors.amber,
              size: 40,
            ),
            Text(
              characteristicEmoji,
            ),
          ],
        ),
      )
    );
  }
}
