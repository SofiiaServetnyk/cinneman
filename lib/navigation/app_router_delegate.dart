import 'package:cinneman/cubit/error_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_state.dart';
import 'package:cinneman/cubit/user/user_cubit.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CinnemanRouterDelegate extends RouterDelegate<RouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfig> {
  @override
  GlobalKey<NavigatorState> navigatorKey;

  final UserCubit _authCubit;
  final NavigationCubit _navigationCubit;
  final ErrorCubit _errorCubit;
  final PageGenerator _pageGenerator;

  CinnemanRouterDelegate(
      {required UserCubit authCubit,
      required NavigationCubit navigationCubit,
      required ErrorCubit errorCubit,
      required PageGenerator pageGenerator})
      : navigatorKey = GlobalKey<NavigatorState>(),
        _authCubit = authCubit,
        _navigationCubit = navigationCubit,
        _errorCubit = errorCubit,
        _pageGenerator = pageGenerator;

  bool get isAuthenticated => _authCubit.state.isAuthenticated;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ErrorCubit, String?>(
      bloc: _errorCubit,
      listener: (context, error) {
        if (error != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error),
            duration: const Duration(seconds: 3),
          ));
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Navigator(
            key: navigatorKey,
            pages:
                state.stack.map((RouteConfig r) => _pageGenerator.createPage(r)).toList(),
            onPopPage: (route, result) {
              if (!route.didPop(result)) {
                return false;
              }

              _navigationCubit.pop();

              return true;
            },
          );
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfig configuration) async {
    bool requiresAuth = [
      AppRoutes.moviesListPage,
      AppRoutes.movieDetailsPage,
      AppRoutes.paymentPage,
      AppRoutes.userProfile,
    ].contains(configuration.route);

    if (requiresAuth && !isAuthenticated) {
      _navigationCubit.goToPage(RouteConfig(route: AppRoutes.login));
    } else {
      _navigationCubit.goToPage(configuration);
    }
  }
}
