import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:flutter/material.dart';

class MovieDetailRow extends StatelessWidget {
  String title;
  String description;
  MovieDetailRow({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
              fontFamily: 'Morganite',
              fontSize: 26,
              color: CustomColors.brown3),
        ),
        Text(description, style: nunito.black),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
