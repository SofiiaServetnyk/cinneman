import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/error_cubit.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/data/models/movie.dart';
import 'package:cinneman/data/models/movie_session_models.dart';
import 'package:cinneman/services/movies_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_button.dart';
import 'widgets/movie_banner.dart';
import 'widgets/seat_grid_row.dart';

class SeatSelectionPage extends StatelessWidget {
  SeatSelectionPage({Key? key}) : super(key: key);

  final TransformationController _transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context) {
    double initialScale = 0.85;
    _transformationController.value = Matrix4.identity()..scale(initialScale);

    var navigationCubit = BlocProvider.of<NavigationCubit>(context);
    var errorCubit = BlocProvider.of<ErrorCubit>(context);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(35.0),
          child: AppBar(
            backgroundColor: CustomColors.white,
            elevation: 0,
            leading: InkWell(
              splashColor: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: CustomColors.brown1,
                ),
                onPressed: () {
                  navigationCubit.pop();
                },
              ),
            ),
          ),
        ),
        body: BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
          int totalPrice = 0;
          Movie movie = state.movieSession!.movie;
          String movieDate =
              DateFormat("d MMMM, HH:mm").format(state.movieSession!.date);

          if (state.selectedSeats != null) {
            for (var s in state.selectedSeats!) {
              totalPrice += s.price;
            }
          }

          return LayoutBuilder(builder: (context, viewportConstraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      PngIcons.seatSelection,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: CustomColors.white.withOpacity(0.9),
                    child: Padding(
                      padding: Paddings.all15,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MovieBanner(
                                  title: movie.name,
                                  duration: movie.duration,
                                  date: movieDate,
                                  imageSrc: movie.smallImage,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: SizedBoxSize.sbs20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColors.brown1.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                    CustomBorderRadius.br),
                              ),
                              child: SizedBox(
                                height: 300,
                                child: InteractiveViewer(
                                  constrained: false,
                                  scaleEnabled: true,
                                  boundaryMargin: const EdgeInsets.all(200),
                                  alignment: Alignment.center,
                                  transformationController:
                                      _transformationController,
                                  minScale: 0.2,
                                  maxScale: 4,
                                  child: Column(
                                      children: List.generate(
                                          state.movieSession!.room.rows.length,
                                          (index) => SeatGridRow(
                                                row: state.movieSession!.room
                                                    .rows[index],
                                              ))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: (state.selectedSeats?.length ?? 0) > 0,
                      child: Positioned(
                        left: 20,
                        right: 20,
                        bottom: 40,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                itemCount: state.selectedSeats?.length,
                                itemBuilder: (context, index) {
                                  Seat seat =
                                      state.selectedSeats!.elementAt(index);
                                  return Padding(
                                    padding: Paddings.all5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: DefaultTextStyle.of(context)
                                                .style,
                                            children: [
                                              TextSpan(
                                                text: 'Row: ',
                                                style: nunito.w500.s20,
                                              ),
                                              TextSpan(
                                                  text: '${seat.rowIndex}  ',
                                                  style: nunito),
                                              TextSpan(
                                                text: 'Seat: ',
                                                style: nunito.w500.s20,
                                              ),
                                              TextSpan(
                                                  text: '${seat.index}',
                                                  style: nunito),
                                            ],
                                          ),
                                        ),
                                        Text('${seat.price} UAH',
                                            style: nunito),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: 'Total price: ',
                                      style: nunito.w500.s20,
                                    ),
                                    TextSpan(
                                        text: '$totalPrice UAH', style: nunito),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: CustomButton(
                                  onPressed: () async {
                                    var moviesService =
                                        Provider.of<MovieService>(context,
                                            listen: false);

                                    Set<Seat> selectedSeats =
                                        state.selectedSeats!;
                                    int sessionId = state.movieSession!.id;

                                    bool success =
                                        await moviesService.bookSeats(
                                            seats: selectedSeats,
                                            sessionId: sessionId);
                                    if (success) {
                                      navigationCubit.openPaymentPage();
                                    } else {
                                      errorCubit.showError(
                                          "Could not book seats, probably they are already booked");
                                    }
                                  },
                                  child:
                                      Text('Buy Tickets', style: nunito.white)),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            );
          });
        }));
  }
}
