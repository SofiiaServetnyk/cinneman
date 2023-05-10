import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/error_cubit.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/cubit/user/user_cubit.dart';
import 'package:cinneman/cubit/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/custom_text_button.dart';
import 'widgets/custom_text_field.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String otp = "";

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
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: SizedBoxSize.sbs25),
                        Image.asset(
                          PngIcons.otpScreen,
                          height: IconSize.bigIconSize,
                        ),
                        const SizedBox(height: SizedBoxSize.sbs25),
                        Text(
                          'Enter the OTP code',
                          style: nunito.s24.white.w500,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: SizedBoxSize.sbs10),
                        Text('Enter 4-digit code sent yo your mobile number',
                            textAlign: TextAlign.center,
                            style: nunito.w400.s14.white),
                        const SizedBox(height: SizedBoxSize.sbs75),
                        CustomTextField(
                          hint: '4-digit code',
                          hintStyle: nunito.yellow1.w500,
                          style: nunito.w500.s16,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          onChanged: (s) {
                            setState(() {
                              otp = s;
                            });
                          },
                        ),
                        const SizedBox(height: SizedBoxSize.sbs100),
                        CustomTextButton(
                            onPressed: () async {
                              await authCubit.validateOtp(otp);

                              if (authCubit.state is Authenticated) {
                                moviesCubit.loadMovies();
                                navigationCubit.startAuthenticated();
                              } else {
                                errorCubit.showError('Could not validate OTP');
                              }
                            },
                            child: Text('Send', style: nunito.s18.yellow1))
                      ],
                    ),
                  ),
                ))));
  }
}
