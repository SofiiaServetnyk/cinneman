import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:flutter/material.dart';

class MovieBanner extends StatelessWidget {
  String title;
  String imageSrc;
  int? duration;
  String date;

  MovieBanner(
      {Key? key,
        required this.title,
        required this.imageSrc,
        this.duration,
        required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Padding(
                padding: Paddings.all10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: CustomColors.brown1,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    foregroundImage: NetworkImage(imageSrc),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: nunito.w500.s22,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    Text(date, style: nunito.s14),
                    Visibility(
                      visible: duration != null,
                      child: Container(
                          decoration: BoxDecoration(
                              color: CustomColors.yellow17,
                              borderRadius:
                              BorderRadius.circular(CustomBorderRadius.br)),
                          child: Padding(
                            padding: Paddings.all5,
                            child:
                            Text('$duration min', style: nunito.s12.white),
                          )),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
