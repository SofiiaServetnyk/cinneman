import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/error_cubit.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/cubit/user/user_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/custom_button.dart';
import 'widgets/custom_text_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<UserCubit>(context);
    var navigationCubit = BlocProvider.of<NavigationCubit>(context);
    var moviesCubit = BlocProvider.of<MoviesCubit>(context);
    var errorCubit = BlocProvider.of<ErrorCubit>(context);

    return Scaffold(
        backgroundColor: CustomColors.brown2,
        body: SafeArea(
          child: Padding(
            padding: Paddings.all24,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: SizedBoxSize.sbs25),
                    Image.asset(
                      PngIcons.welcomeScreen,
                      height: IconSize.bigIconSize,
                    ),
                    const SizedBox(height: SizedBoxSize.sbs50),
                    Text('Welcome to CINNEMAN! 🎬',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustomColors.yellow1,
                          fontFamily: 'Morganite',
                          fontSize: 36,
                          letterSpacing: 1.2,
                        )),
                    const SizedBox(height: SizedBoxSize.sbs45),
                    Text(
                      textAlign: TextAlign.center,
                      "Log in to unlock the full taste of our cinema experience and become a gourmet, or continue as a guest for a quick bite.",
                      style: nunito.s16.white,
                    ),
                    const SizedBox(height: SizedBoxSize.sbs75),
                    CustomButton(
                        onPressed: () {
                          navigationCubit.openLoginPage();
                        },
                        child: Text('Log in, I am gourmet',
                            style: nunito.s18.white)),
                    const SizedBox(height: SizedBoxSize.sbs25),
                    CustomTextButton(
                        onPressed: () async {
                          await authCubit.loginAsGuest();

                          if (authCubit.state.isAuthenticated) {
                            moviesCubit.loadMovies();
                            navigationCubit.startAuthenticated();
                          } else {
                            errorCubit.showError(
                                "Could not login as Guest. Please check your internet connection.");
                          }
                        },
                        child: Text('I am guest, just want a bite',
                            style: nunito.s18.yellow1)),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
