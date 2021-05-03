import 'package:flutter/material.dart';
import 'package:hagglex/landing.dart';
import 'package:provider/provider.dart';

import 'AppEngine/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CountryModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final HttpLink httpLink =
    //     HttpLink(uri: "https://hagglex-backend-staging.herokuapp.com/graphql");
    // final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    //   GraphQLClient(
    //     link: httpLink as Link,
    //     cache: OptimisticCache(
    //       dataIdFromObject: typenameDataIdFromObject,
    //     ),
    //   ),
    // );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, fontFamily: "BasisGrotesquePro"),
      home: Landing(),
    );
  }
}
