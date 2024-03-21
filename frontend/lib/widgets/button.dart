import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.subText = "",
  });

  final VoidCallback onPressed;

  final String text;

  final String subText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8)),
          child: Text(text).text.black.xl2.bold.make(),
        ).wPCT(context: context, widthPCT: 75).px16(),
        Visibility(
          visible: subText.isNotEmpty,
          child: Text(subText).text.gray400.make(),
        ).pOnly(top: 8)
      ],
    );
  }
}
