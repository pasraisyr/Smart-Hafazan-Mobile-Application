import 'package:smart_hafazan/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_hafazan/providers/app_provider.dart';

class DrawerAppName extends StatelessWidget {
  const DrawerAppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "\n",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: height * 0.025,
                color: appProvider.isDark ? Colors.grey[200] : Colors.black54,
              ),
            ),
            Text(
              "Smart\nHafazan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: appProvider.isDark ? Colors.grey[200] : Colors.black54,
                fontSize: height * 0.035,
              ),
            )
          ],
        ),
        Image.asset(
          StaticAssets.gradLogo,
          height: height * 0.17,
        )
      ],
    );
  }
}
