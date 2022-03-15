import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: LoadingIndicator(
        indicatorType: Indicator.ballPulseRise,
        colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColorDark,
          Theme.of(context).colorScheme.secondary,
        ],
      ),
    );
  }
}
