import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/data/models/movie.dart';
import 'package:flutter/material.dart';

class MoviePreview extends StatelessWidget {
  Movie movie;

  MoviePreview({required this.movie});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 250,
        width: ButtonSize.minWidth,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(CustomBorderRadius.br),
                child: Image.network(
                  movie.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(CustomBorderRadius.br),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          CustomColors.brown1,
                          Colors.transparent,
                        ])),
              ),
            ),
            Padding(
              padding: Paddings.all15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColors.yellow17,
                        ),
                        child: Center(
                            child: Text(
                                style: nunito.brown1.s14.w800,
                                '${movie.age}+')))
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                movie.name,
                                style: nunito.white.w800.s24),
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              movie.genre,
                              style: nunito.white.w300,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            style: nunito.white.w300,
                            '${movie.duration} min',
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    // color: Colors.purple);
  }
}
