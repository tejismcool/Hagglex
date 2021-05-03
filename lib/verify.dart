import "package:flutter/material.dart";
import 'package:graphql/client.dart';
import 'package:hagglex/done.dart';
import 'package:provider/provider.dart';

import 'AppEngine/Button.dart';
import 'AppEngine/Helpers.dart';
import 'AppEngine/TextField.dart';
import 'AppEngine/TextStyles.dart';
import 'AppEngine/TextStyles.dart';
import 'AppEngine/TextStyles.dart';
import 'AppEngine/colors.dart';
import 'AppEngine/colors.dart';
import 'AppEngine/colors.dart';
import 'AppEngine/graphql.dart';
import 'AppEngine/provider.dart';

class Verify extends StatelessWidget {
  const Verify({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GraphQLClient _client;
    CountryModel provider = Provider.of<CountryModel>(context, listen: false);
    _client = GraphQL('https://hagglex-backend-staging.herokuapp.com/graphql')
        .getClient(token: provider.token);
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
              spacerH(20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: backButton(() {
                    Navigator.pop(context);
                  })),
              spacerH(35),
              Text(
                "Verify Your Account",
                style: mediumHeader(AppColors.white),
              ),
              spacerH(40),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(27.0, 40.0, 27.0, 67.0),
                      //height: 500,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            "images/ok.png",
                            height: 64,
                          ),
                          spacerH(35),
                          Text(
                            "We just sent a verification code to your email. Please enter the code",
                            style: regular(AppColors.black),
                            textAlign: TextAlign.center,
                          ),
                          spacerH(55),
                          appTextField(
                              onChanged: (v) {
                                provider.user.verifyCode = int.tryParse(v);

                                print(provider.user.verifyCode);
                              },
                              hint: "Verification code",
                              color: AppColors.black),
                          spacerH(35),
                          Consumer<CountryModel>(
                              builder: (context, data, child) {
                            return data.loading
                                ? Center(child: CircularProgressIndicator())
                                : gradientButton("VERIFY ME", () async {
                                    data.setLoading(true);
                                    handleResult(
                                        await _client
                                            .mutateVerify(data.user.verifyCode),
                                        context,
                                        data);
                                  });
                          }),
                          spacerH(28),
                          Text(
                            "This code will expire in 10 minutes",
                            style: regular(AppColors.black),
                            textAlign: TextAlign.center,
                          ),
                          spacerH(49),
                          Consumer<CountryModel>(
                              builder: (context, data, child) {
                            return data.loading
                                ? Center(child: CircularProgressIndicator())
                                : clearButton("RESEND CODE", () async {
                                    data.setLoading(true);
                                    handleResult2(
                                        await _client
                                            .queryVerify(data.user.email),
                                        context,
                                        data);
                                  }, color: AppColors.black);
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

  void handleResult(QueryResult result, context, data) {
    if (result.data != null) {
      data.setLoading(false);
      data.token = result.data["action"]["token"];
      print(result.data);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Done()),
      );
      return;
    }

    if (result.hasException) {
      print(result.exception);
      data.setLoading(false);
      _showDialog(context);
    }
    print("nodata");
  }

  void handleResult2(QueryResult result, context, data) {
    if (result.data != null) {
      data.setLoading(false);
      if (!result.data["resendVerificationCode"]) {
        _showDialog(context);
      }
      print(result.data);

      return;
    }

    if (result.hasException) {
      print(result.exception);
      data.setLoading(false);
      _showDialog(context);
    }
    print("nodata");
  }

  // user defined function
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Seems like we had a server error"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            clearButton("Close", () => Navigator.of(context).pop(),
                color: AppColors.primary)
          ],
        );
      },
    );
  }
}
