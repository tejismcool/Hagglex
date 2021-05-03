import "package:flutter/material.dart";
import 'package:hagglex/dashboard.dart';

import 'AppEngine/Button.dart';
import 'AppEngine/Button.dart';
import 'AppEngine/Helpers.dart';
import 'AppEngine/TextField.dart';
import 'AppEngine/TextStyles.dart';
import 'AppEngine/TextStyles.dart';
import 'AppEngine/TextStyles.dart';
import 'AppEngine/colors.dart';
import 'AppEngine/colors.dart';
import 'AppEngine/colors.dart';

class Done extends StatelessWidget {
  const Done({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/back.png"), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(27.0, 200.0, 27.0, 67.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            "images/ok2.png",
                            height: 64,
                          ),
                          spacerH(18),
                          Text(
                            "Setup Complete",
                            style: header(AppColors.white),
                            textAlign: TextAlign.center,
                          ),
                          spacerH(18),
                          Text(
                            "Thank you for setting up your HaggleX account",
                            style: regular(AppColors.white),
                            textAlign: TextAlign.center,
                          ),
                          spacerH(222),
                          yellowButton("START EXPLORING", () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()),
                            );
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
