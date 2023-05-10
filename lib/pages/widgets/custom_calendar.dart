import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/error_cubit.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/data/models/movie.dart';
import 'package:cinneman/data/models/movie_session_models.dart';

import 'package:cinneman/pages/widgets/custom_button.dart';
import 'package:cinneman/services/movies_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'session_button.dart';

class CustomCalendar extends StatefulWidget {
  Movie movie;
  DateTime firstDay;
  DateTime lastDay;

  CustomCalendar(
      {Key? key, required this.movie, DateTime? firstDay, DateTime? lastDay})
      : firstDay = firstDay ?? DateTime.now(),
        lastDay = lastDay ??
            DateTime(DateTime.now().year, DateTime.now().month + 3, 0,
                DateTime.now().day),
        super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  bool loading = true;
  List<MovieSession> sessions = [];
  MovieSession? selectedSession;

  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    var sessions = await loadSessions(widget.firstDay);

    setState(() {
      this.sessions = sessions;
    });
  }

  Future<List<MovieSession>> loadSessions(DateTime day) async {
    setState(() {
      loading = true;
    });

    try {
      var movieService = Provider.of<MovieService>(context, listen: false);
      var sessions =
          await movieService.getMovieSessions(movie: widget.movie, date: day);
      sessions.sort((a, b) => a.date.compareTo(b.date));

      setState(() {
        loading = false;
      });

      return sessions;
    } catch (e) {
      setState(() {
        loading = false;
      });

      var errorCubit = BlocProvider.of<ErrorCubit>(context);
      if (e is MoviesServiceException) {
        errorCubit.showError(e.message);
      } else {
        errorCubit
            .showError('An unexpected error occurred: $e');
      }

      return [];
    }
  }

  void onDaySelected(DateTime day, DateTime focusedDay) async {
    List<MovieSession> sessions = await loadSessions(day);

    setState(() {
      this.focusedDay = day;
      this.sessions = sessions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      TableCalendar(
          daysOfWeekStyle:
              DaysOfWeekStyle(weekdayStyle: nunito, weekendStyle: nunito),
          rowHeight: 40,
          startingDayOfWeek: StartingDayOfWeek.monday,
          selectedDayPredicate: (day) => isSameDay(day, focusedDay),
          availableGestures: AvailableGestures.all,
          onDaySelected: onDaySelected,
          headerStyle: HeaderStyle(
            rightChevronIcon:
                Icon(Icons.arrow_circle_right, color: CustomColors.yellow1),
            leftChevronIcon:
                Icon(Icons.arrow_circle_left, color: CustomColors.yellow1),
            formatButtonTextStyle: nunito,
            titleTextStyle: nunito.s18,
            formatButtonVisible: false,
            titleCentered: true,
          ),
          focusedDay: focusedDay,
          firstDay: DateTime.now(),
          calendarStyle: CalendarStyle(
              weekendTextStyle: nunito,
              selectedDecoration: BoxDecoration(
                color: CustomColors.yellow2,
                shape: BoxShape.circle,
              ),
              outsideTextStyle: nunito.grey,
              todayDecoration: BoxDecoration(
                  color: CustomColors.yellow1, shape: BoxShape.circle),
              defaultTextStyle: nunito,
              disabledTextStyle: nunito.grey),
          lastDay: widget.lastDay),
      const Divider(),
      const SizedBox(height: SizedBoxSize.sbs10),
      Container(
          child: Text(
        "Sweet Showtime:".toUpperCase(),
        style: TextStyle(
            fontFamily: 'Morganite', fontSize: 28, color: CustomColors.brown3),
      )),
      const SizedBox(height: SizedBoxSize.sbs10),
      Padding(
        padding: Paddings.all5,
        child: SizedBox(
          height: 50,
          child: loading
              ? Text('Loading...', style: nunito)
              : Center(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sessions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SessionSelectionButton(
                          sessionTime: DateFormat('HH:mm')
                              .format(sessions[index].date),
                          selected: selectedSession != null &&
                              selectedSession == sessions[index],
                          onTap: () {
                            setState(() {
                              selectedSession = sessions[index];
                            });
                          },
                        );
                      }),
                ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: CustomButton(
            onPressed: () {
              if (selectedSession != null) {
                BlocProvider.of<MoviesCubit>(context)
                    .selectSession(selectedSession!);
                BlocProvider.of<NavigationCubit>(context)
                    .openMovieSessionPage(selectedSession!);
              }
            },
            child: Text('Select Seats', style: nunito.white)),
      ),
      const SizedBox(height: SizedBoxSize.sbs25)
    ]);
  }
}
