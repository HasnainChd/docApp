import 'package:flutter/material.dart';

import '../../consts/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const CustomElevatedButton({super.key,required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(

          backgroundColor: appTheme.primaryColor,
          foregroundColor: Colors.black,

        ),
        child: Text(buttonText),
      ),
    );
  }
}
