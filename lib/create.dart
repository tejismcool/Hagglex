import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:graphql/client.dart';
import 'package:hagglex/AppEngine/model.dart';
import 'package:hagglex/AppEngine/validator.dart';
import 'package:hagglex/verify.dart';
import 'package:provider/provider.dart';

import 'AppEngine/Button.dart';
import 'AppEngine/Button.dart';
import 'AppEngine/Helpers.dart';
import 'AppEngine/TextField.dart';
import 'AppEngine/TextStyles.dart';
import 'AppEngine/colors.dart';
import 'AppEngine/graphql.dart';
import 'AppEngine/provider.dart';

class CreateAccount extends StatelessWidget {
  // const CreateAccount({Key key}) : super(key: key);
  CountryModel provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CountryModel>(context, listen: false);
    final _formKey = GlobalKey<FormState>();
    GraphQLClient _client;
    _client = GraphQL('https://hagglex-backend-staging.herokuapp.com/graphql')
        .getClient();

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
              spacerH(24),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(27.0, 40.0, 27.0, 67.0),
                      //height: 500,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            spacerH(40.0),
                            Text(
                              "Create a new account",
                              style: header(AppColors.black),
                            ),
                            spacerH(44.0),
                            appFormTextField(
                                validator: formValidator,
                                hint: "Email Address",
                                color: AppColors.black,
                                keytype: TextInputType.emailAddress,
                                onSubmit: (v) => provider.user.email = v),
                            spacerH(44.0),
                            appFormTextField(
                              validator: formValidator,
                              hint: "Password (Min 8 characters)",
                              color: AppColors.black,
                              onSubmit: (v) => provider.user.password = v,
                            ),
                            spacerH(44.0),
                            appFormTextField(
                              validator: formValidator,
                              hint: "Create a username",
                              color: AppColors.black,
                              onSubmit: (v) => provider.user.username = v,
                            ),
                            spacerH(44.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 75,
                                  height: 36,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all(
                                        color: Colors.grey[400],
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.network(
                                        provider.country.flag,
                                        width: 30.0,
                                        placeholderBuilder:
                                            (BuildContext context) => Icon(
                                          Icons.flag,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      spacerV(5),
                                      Text("+${provider.country.callingCode}")
                                    ],
                                  ),
                                ),
                                spacerV(5.5),
                                Expanded(
                                  child: appFormTextField(
                                    validator: formValidator,
                                    hint: "Enter your phone number",
                                    color: AppColors.black,
                                    keytype: TextInputType.phone,
                                    onSubmit: (v) =>
                                        provider.user.phonenumber = v,
                                  ),
                                ),
                              ],
                            ),
                            spacerH(44.0),
                            appFormTextField(
                                validator: null,
                                onSubmit: (v) => provider.user.referralCode = v,
                                hint: "Referral code (optional)",
                                color: Colors.grey[400]),
                            spacerH(25.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: clearButton(
                                  "By signing, you agree to HaggleX terms and privacy policy.",
                                  () {},
                                  color: AppColors.black),
                            ),
                            spacerH(44.0),
                            Consumer<CountryModel>(
                                builder: (context, data, child) {
                              return data.loading
                                  ? Center(child: CircularProgressIndicator())
                                  : gradientButton("SIGN UP", () async {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();

                                        provider.user.callingCode =
                                            provider.country.callingCode;
                                        provider.user.flag = Uri.encodeFull(
                                            provider.country.flag);
                                        provider.user.currency =
                                            provider.country.currencyCode;
                                        provider.user.country =
                                            provider.country.name;
                                        data.setLoading(true);
                                        handleResult(
                                            await _client.mutateCharacter(
                                                GraphQL.registerMutation,
                                                provider.user),
                                            context);
                                      }
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => Verify()),
                                      // );
                                    });
                            })
                          ],
                        ),
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

  void handleResult(QueryResult result, context) {
    if (result.data != null) {
      provider.setLoading(false);
      provider.token = result.data["action"]["token"];
      print(result.data);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Verify()),
      );
      return;
    }

    if (result.hasException) {
      print(result.exception);
      provider.setLoading(false);
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
