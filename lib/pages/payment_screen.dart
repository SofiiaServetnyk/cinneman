import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/regex.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/error_cubit.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/cubit/user/user_cubit.dart';
import 'package:cinneman/services/movies_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? cardNumber;
  String? expirationDate;
  String? cvv;
  String? email;

  Future<void> _handlePayment() async {
    if (cardNumber == null ||
        expirationDate == null ||
        cvv == null ||
        email == null) {
      throw MoviesServiceException("Please fill in all the fields.");
    } else {
      final RegExp cardNumberRegExp = RegexPatterns.cardNumberRegExp;
      final RegExp expirationDateRegExp =
          RegexPatterns.expirationDateRegExp;
      final RegExp cvvRegExp = RegexPatterns.cvvRegExp;


      String cleanedCardNumber =
          cardNumber!.replaceAll(RegexPatterns.cleanedCardNumber, "");

      if (!cardNumberRegExp.hasMatch(cleanedCardNumber)) {

        throw MoviesServiceException("Invalid card number");
      } else if (!expirationDateRegExp.hasMatch(expirationDate!)) {

        throw MoviesServiceException(
            "Invalid expiration date");
      } else if (!cvvRegExp.hasMatch(cvv!)) {

        throw MoviesServiceException(
            "Invalid CVV");
      } else {
        var moviesCubit = BlocProvider.of<MoviesCubit>(context);

        final session = moviesCubit.state.movieSession;
        final seats = moviesCubit.state.selectedSeats;
        if (session == null || seats == null) {

          throw MoviesServiceException("Please select a session and seats");
        } else {
          await moviesCubit.buyTickets(
            seats: seats.toList(),
            session: session,
            email: email!,
            cardNumber: cleanedCardNumber,
            expirationDate: expirationDate!,
            cvv: cvv!,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var userCubit = BlocProvider.of<UserCubit>(context);
    var navigationCubit = BlocProvider.of<NavigationCubit>(context);
    var moviesCubit = BlocProvider.of<MoviesCubit>(context);
    var errorCubit = BlocProvider.of<ErrorCubit>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.brown1),
        title: Text("Add your payment information: ", style: nunito.black.s20),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: CustomColors.white,
      body: SafeArea(
        child: Padding(
          padding: Paddings.all24,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    PngIcons.paymentScreen,
                    height: IconSize.smallIconSize,
                  ),
                  const SizedBox(
                    height: SizedBoxSize.sbs25,
                  ),
                  CustomTextField(
                    onChanged: (value) =>
                        setState(() => cardNumber = value),
                    prefixIcon: Padding(
                      padding: Paddings.all5,
                      child: Image.asset(
                        height: ButtonSize.sessionMinHeight,
                        PngIcons.cardIcon,
                        fit: BoxFit.cover,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    hint: "Card number",
                    formatter: "space",
                    enabledBorder: CustomColors.grey,
                    focusBorder: CustomColors.brown1,
                    limitTextInput: 19,
                  ),
                  const SizedBox(
                    height: SizedBoxSize.sbs10,
                  ),
                  Padding(
                    padding: Paddings.all5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                            onChanged: (value) =>
                                setState(() => expirationDate = value),
                            prefixIcon: Padding(
                              padding: Paddings.all5,
                              child: Image.asset(
                                height: ButtonSize.sessionMinHeight,
                                PngIcons.calendarIcon,
                                fit: BoxFit.cover,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            formatter: "slash",
                            enabledBorder: CustomColors.grey,
                            focusBorder: CustomColors.brown1,
                            maxWidth: ButtonSize.paymentMaxWidth,
                            hint: "MM/YY",
                            limitTextInput: 5),
                        // const SizedBox(
                        //   height: SizedBoxSize.sbs15,
                        // ),
                        CustomTextField(
                            onChanged: (value) =>
                                setState(() => cvv = value),
                            prefixIcon: Padding(
                              padding: Paddings.all5,
                              child: Image.asset(
                                height: ButtonSize.sessionMinHeight,
                                PngIcons.cvvIcon,
                                fit: BoxFit.cover,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            hint: "CVV",
                            enabledBorder: CustomColors.grey,
                            focusBorder: CustomColors.brown1,
                            maxWidth: ButtonSize.paymentMaxWidth,
                            limitTextInput: 3),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SizedBoxSize.sbs10,
                  ),
                  CustomTextField(
                      onChanged: (value) => setState(() => email = value),
                      prefixIcon: Padding(
                        padding: Paddings.all5,
                        child: SizedBox(
                          height: 15,
                          width: 15,
                          child: Padding(
                            padding: Paddings.all5,
                            child: Image.asset(
                              PngIcons.emailIcon,
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      hint: "Email",
                      enabledBorder: CustomColors.grey,
                      focusBorder: CustomColors.brown1,
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(
                    height: SizedBoxSize.sbs30,
                  ),
                  BlocBuilder<MoviesCubit, MoviesState>(
                    builder: (context, state) {
                      int totalPrice = 0;
                      if (state.selectedSeats != null) {
                        for (var s in state.selectedSeats!) {
                          totalPrice += s.price;
                        }
                      }

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                               TextSpan(
                                text: 'Total price: ',
                                style: nunito.s20.w500,
                              ),
                              TextSpan(
                                text: '$totalPrice UAH', style: nunito,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  CustomButton(
                      onPressed: () async {
                        try {
                          await _handlePayment();
                        } catch (e) {
                          if (e is MoviesServiceException) {
                            errorCubit.showError(e.message);

                            return;
                          } else {
                            rethrow;
                          }
                        }

                        if (moviesCubit.state
                        is SuccessfulPaymentMovieState) {
                          userCubit.loadTickets();
                          navigationCubit.openUserPageAfterSuccessfulPayment();
                        } else {
                          errorCubit.showError("Could not process payment");
                        }
                      },
                      child: Text(
                        'Delicious Payment',
                        style: nunito.white,
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
