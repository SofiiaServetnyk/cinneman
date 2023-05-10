import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/data/models/movie_session_models.dart';
import 'package:cinneman/pages/seat_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'row_number_container.dart';
import 'seat_container.dart';

class SeatGridRow extends StatelessWidget {
  SeatRow row;

  SeatGridRow({Key? key, required this.row}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        RowNumberContainer(numberOfRows: row.index),
        BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
          return Wrap(
            direction: Axis.horizontal,
            children: [
              ...List.generate(
                  row.seats.length,
                      (index) => SeatContainer(
                      index: row.seats[index].index,
                      type: row.seats[index].type,
                      available: row.seats[index].isAvailable,
                      onTap: () {
                        if (row.seats[index].isAvailable ||
                            state.selectedSeats?.contains(row.seats[index]) ==
                                true) {
                          BlocProvider.of<MoviesCubit>(context)
                              .toggleSeat(row.seats[index]);
                        }
                      },
                      selected:
                      state.selectedSeats?.contains(row.seats[index]) ??
                          false))
            ],
          );
        })
      ],
    );
  }
}