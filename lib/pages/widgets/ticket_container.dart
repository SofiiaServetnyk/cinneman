import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/pages/widgets/movie_banner.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketContainer extends StatelessWidget {
  int ticketId;
  String title;

  DateTime date;
  String image;

  TicketContainer(
      {Key? key,
        required this.ticketId,
        required this.date,
        required this.image,
        required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var qrContent = "movie/$ticketId";

    return Container(
      width: 350,
      decoration: BoxDecoration(
          color: CustomColors.grey,
          borderRadius: BorderRadius.circular(CustomBorderRadius.br)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              MovieBanner(
                title: title,
                date: DateFormat("d MMMM, HH:mm").format(date),
                imageSrc: image,
              )
            ],
          ),
          Padding(
            padding: Paddings.all15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: Paddings.all15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: QrImage(
                          data: qrContent,
                          version: QrVersions.auto,
                          size: 225.0,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}