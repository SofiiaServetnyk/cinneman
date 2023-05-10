import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget {
  Color? color;
  String? title;

  CustomAppBar({Key? key, this.color, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigationCubit = BlocProvider.of<NavigationCubit>(context);

    return AppBar(
      backgroundColor: color ?? CustomColors.brown1,
      elevation: 0.0,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title ?? ''),
              GestureDetector(
                onTap: () {
                  navigationCubit
                      .openUserPage();
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: CustomColors.yellow1),
                  child: Image.asset(
                    PngIcons.cinnemanIcon,
                    color: CustomColors.white,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}