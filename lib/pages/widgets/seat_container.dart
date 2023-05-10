import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/data/models/movie_session_models.dart';
import 'package:flutter/material.dart';

class SeatContainer extends StatelessWidget {
  int index;
  SeatType type = SeatType.NORMAL;
  bool available;
  bool selected = false;
  Function()? onTap;

  SeatContainer(
      {Key? key,
        required this.index,
        required this.type,
        required this.available,
        this.onTap,
        bool? selected})
      : selected = selected ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color seatColor;
    switch (type) {
      case SeatType.VIP:
        seatColor =  CustomColors.purple;
        break;

      case SeatType.BETTER:
        seatColor =  CustomColors.blue;
        break;

      default:
        seatColor = CustomColors.red;
    }

    if (selected) {
      seatColor = CustomColors.grey;
    }

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: available || selected ? 1 : 0.25,
        child: Container(
          width: 38,
          margin: const EdgeInsets.all(5),
          child: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.vertical,
                children: [
                  Container(
                    width: 38,
                    decoration: BoxDecoration(
                      color: seatColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        // color: selected ? CustomColors.black : Colors.black,
                        width: selected ? 4.0 : 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: ClipOval(
                        child: Image.asset(
                          color: Colors.black,
                          fit: BoxFit.contain,
                          PngIcons.betterSeat,
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 38,
                      child: Center(
                          child: Text(
                            index.toString(),
                            style: nunito.s12,
                          )))
                ],
              )),
        ),
      ),
    );
  }
}