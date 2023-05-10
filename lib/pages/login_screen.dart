import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/error_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/cubit/user/user_cubit.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/custom_text_field.dart';
import 'widgets/custom_text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<UserCubit>(context);
    var navigationCubit = BlocProvider.of<NavigationCubit>(context);
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
                        PngIcons.phoneNumberScreen,
                        height: IconSize.bigIconSize,
                      ),
                      const SizedBox(height: SizedBoxSize.sbs25),
                      Text(
                        'Enter your phone number',
                        style: nunito.s24.white.w500,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: SizedBoxSize.sbs10),
                      Text('We will send you the OTP code',
                          textAlign: TextAlign.center,
                          style: nunito.w400.s14.white),
                      const SizedBox(height: SizedBoxSize.sbs75),
                      CustomTextField(
                        hint: 'Phone number',
                        hintStyle: nunito.yellow1.w500,
                        style: nunito.w500.s16,
                        keyboardType: TextInputType.phone,
                        fillColor: CustomColors.grey,
                        maxLength: 20,
                        onChanged: (s) {
                          setState(() {
                            phoneNumber = s.replaceAll(' ', '');
                          });
                        },
                      ),
                      const SizedBox(height: SizedBoxSize.sbs100),
                      CustomTextButton(
                          onPressed: () async {
                            if (phoneNumber.isEmpty) {
                              errorCubit.showError("Please enter phone number");
                              return;
                            }

                            await authCubit.enterPhoneNumber(phoneNumber);

                            if (authCubit.state.phoneNumber != null) {
                              navigationCubit.openOtpPage();
                            } else {
                              errorCubit.showError("Could not send OTP");
                            }
                          },
                          child: Text('Send', style: nunito.s18.yellow1))
                    ],
                  ),
                )))));
  }
}
