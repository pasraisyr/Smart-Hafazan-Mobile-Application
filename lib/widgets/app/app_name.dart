import 'package:smart_hafazan/configs/app_typography.dart';
import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.12,
      left: MediaQuery.of(context).size.width * 0.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Your",
            style: AppText.h2!.copyWith(
              color: Colors.grey,
            ),
          ),
          Text(
            "Smart\nHafazan",
            style: AppText.h1!.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 129, 128, 128),
              height: 1.0,
            ),
          )
        ],
      ),
    );
  }
}
