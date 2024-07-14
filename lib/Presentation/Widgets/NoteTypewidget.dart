import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/core/constants/colors.dart';

class Notetypewidget extends StatelessWidget {
  final String name;
  final String iconPath;
  const Notetypewidget({required this.name, required this.iconPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                height: 30,
                width: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: const TextStyle(color: Appcolors.white, fontSize: 25),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Appcolors.lightgrey,
          )
        ],
      ),
    );
  }
}
