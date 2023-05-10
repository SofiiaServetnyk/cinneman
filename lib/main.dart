import 'package:cinneman/cubit/error_cubit.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/cubit/user/user_cubit.dart';
import 'package:cinneman/navigation/app_router_delegate.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:cinneman/services/movies_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = UserCubit();
    final NavigationCubit navigationCubit = NavigationCubit(userCubit);
    final MoviesCubit moviesCubit = MoviesCubit(userCubit);
    final ErrorCubit errorCubit = ErrorCubit();

    initializeData() async {
      await userCubit.loadStoredState();

      Future.delayed(const Duration(seconds: 2))
          .then((_) => navigationCubit.loadInitialNavigation());

      if (userCubit.state.isAuthenticated) {
        try {
          moviesCubit.loadMovies();
        } catch (e) {
          errorCubit.showError('Failed to load movies');
        }
      }
    }

    initializeData();

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => userCubit),
          BlocProvider(create: (_) => navigationCubit),
          BlocProvider(create: (_) => moviesCubit),
          BlocProvider(create: (_) => errorCubit),
          Provider<MovieService>(create: (_) => MovieService(userCubit)),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Cinneman',
          routerDelegate: CinnemanRouterDelegate(
              authCubit: userCubit,
              navigationCubit: navigationCubit,
              errorCubit: errorCubit,
              pageGenerator: PageGenerator()),
        ));
  }
}
