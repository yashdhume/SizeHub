import 'package:flutter/material.dart';

class SizeWidget extends StatelessWidget {
  final String typeSize;
  final String size;

  SizeWidget({@required this.typeSize, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(color: Color(0xFFACACAC)),
        children: [
          TextSpan(text: "$typeSize\n"),
          TextSpan(
            text: size,
            style: TextStyle(
                color: Color(0xFF535353),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
