import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql/client.dart';
import 'package:hagglex/AppEngine/TextStyles.dart';
import 'package:hagglex/AppEngine/colors.dart';
import 'package:hagglex/countries.dart';
import 'package:hagglex/dashboard.dart';
import 'package:provider/provider.dart';

import 'AppEngine/Button.dart';
import 'AppEngine/Helpers.dart';
import 'AppEngine/TextField.dart';
import 'AppEngine/graphql.dart';
import 'AppEngine/provider.dart';
import 'AppEngine/validator.dart';

class Landing extends StatelessWidget {
  //const Landing({Key key}) : super(key: key);
  CountryModel provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CountryModel>(context, listen: false);
    provider.setLoading(false);
    final _formKey = GlobalKey<FormState>();
    GraphQLClient _client;
    _client = GraphQL('https://hagglex-backend-staging.herokuapp.com/graphql')
        .getClient();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Container(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/back.png"), fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        spacerH(150),
                        Text(
                          "Welcome!",
                          style: bigHeader(),
                        ),
                        spacerH(60),
                        appFormTextField(
                          validator: formValidator,
                          hint: "Email Address",
                          color: AppColors.white,
                          onSubmit: (v) => provider.user.email = v,
                        ),
                        spacerH(40),
                        appFormTextField(
                          validator: formValidator,
                          hint: "Password (Min. 8 characters)",
                          color: AppColors.white,
                          onSubmit: (v) => provider.user.password = v,
                        ),
                        spacerH(32),
                        Align(
                          alignment: Alignment.centerRight,
                          child: clearButton("Forgot Password?", () {}),
                        ),
                        spacerH(44),
                        Consumer<CountryModel>(builder: (context, data, child) {
                          return data.loading
                              ? Center(child: CircularProgressIndicator())
                              : yellowButton("LOG IN", () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();

                                    data.setLoading(true);
                                    handleResult(
                                        await _client
                                            .mutateLogin(provider.user),
                                        context,
                                        data);
                                  }
                                });
                        }),
                        spacerH(33),
                        clearButton("New User? Create a new account", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Countries()),
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            )),
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
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
      return;
    }

    if (result.hasException) {
      print(result.exception);
      data.setLoading(false);
      _showDialog(context);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Dashboard()),
      // );
    }
    print("nodata");
  }

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
