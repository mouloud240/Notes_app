import 'package:flutter/material.dart';
import 'package:note_app/core/constants/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final IconData buttonIcon;
  final Function onclickFuntction;
  const CustomButtonWidget(
      {super.key, required this.buttonIcon, required this.onclickFuntction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.18,
        width: MediaQuery.of(context).size.width * 0.18,
        child: FloatingActionButton(
            shape: const CircleBorder(),
            foregroundColor: Appcolors.white,
            backgroundColor: Appcolors.lightBlue,
            onPressed: () {
              onclickFuntction();
              print("Clicked button");
            },
            splashColor: Colors.transparent,
            child: Icon(
              buttonIcon,
              size: 30,
            )),
      ),
    );
  }
}
