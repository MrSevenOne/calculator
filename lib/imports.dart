import 'package:calculator/provider/calculator_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

const buttonsBackgroundColor = Color(0xFF17181A);
const backgroundColor = Color(0xFF17181A);
const yellowColor = Color(0xFFF7CF32);
const whiteColor = Colors.white;

AppBar appbar(
  BuildContext context,
  String title,
  IconData icon,
  Function() tap,
) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w500, color: whiteColor),
    ),
    actions: [
      IconButton(
        color: whiteColor,
        onPressed: tap,
        icon: Icon(icon),
      ),
    ],
  );
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final bool isColored, isEqualSign, canBeFirst;

  const CalculatorButton(
    this.label, {
    this.isColored = false,
    this.isEqualSign = false,
    this.canBeFirst = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatorProvider =
        Provider.of<CalculatorProvider>(context, listen: false);
    final TextStyle? textStyle = Theme.of(context).textTheme.titleLarge;
    return Material(
      color: buttonsBackgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(100.0),
        onTap: () {
          calculatorProvider.addToEquation(
            label,
            canBeFirst,
            context,
          );
        },
        child: Center(
          child: isEqualSign
              ? Container(
                  width: 60,
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: ShapeDecoration(
                    color: Color(0xFFFF9500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: textStyle?.copyWith(color: backgroundColor),
                    ),
                  ),
                )
              : Container(
                  width: 60,
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: ShapeDecoration(
                    color: Color(0xFF505050),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF505050)),
                      borderRadius: BorderRadius.circular(108),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: textStyle?.copyWith(
                          color: isColored ? yellowColor : whiteColor),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

void showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 400),
    ),
  );
}

List<CalculatorButton> buttons = <CalculatorButton>[
  CalculatorButton('AC', canBeFirst: false),
  CalculatorButton('.', canBeFirst: false),
  CalculatorButton('⌫', canBeFirst: false),
  CalculatorButton(' ÷ ', isColored: true, canBeFirst: false),
  CalculatorButton('7'),
  CalculatorButton('8'),
  CalculatorButton('9'),
  CalculatorButton(' × ', isColored: true, canBeFirst: false),
  CalculatorButton('4'),
  CalculatorButton('5'),
  CalculatorButton('6'),
  CalculatorButton(' - ', isColored: true, canBeFirst: false),
  CalculatorButton('1'),
  CalculatorButton('2'),
  CalculatorButton('3'),
  CalculatorButton(' + ', isColored: true, canBeFirst: false),
  CalculatorButton('00'),
  CalculatorButton('0'),
  CalculatorButton('000'),
  CalculatorButton('=', isEqualSign: true, canBeFirst: false),
];
