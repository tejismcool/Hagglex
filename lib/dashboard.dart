import 'package:flutter/material.dart';

import 'AppEngine/TextStyles.dart';
import 'AppEngine/colors.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Text(
          "Dashboard",
          style: bigHeader(
            color: AppColors.black,
          ),
        )),
      ),
    );
  }
}
