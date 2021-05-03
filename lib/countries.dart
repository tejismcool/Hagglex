import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql/client.dart';
import 'package:hagglex/AppEngine/model.dart';
import 'package:provider/provider.dart';
import 'AppEngine/Helpers.dart';
import 'AppEngine/TextField.dart';
import 'AppEngine/TextStyles.dart';
import 'AppEngine/colors.dart';
import 'AppEngine/colors.dart';
import 'AppEngine/graphql.dart';
import 'AppEngine/provider.dart';
import 'create.dart';

class Countries extends StatefulWidget {
  const Countries({Key key}) : super(key: key);

  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  GraphQLClient _client;
  CountryModel provider;
  void handleResult(QueryResult result) {
    if (result.data != null) {
      List<CountryData> _countries = [];
      for (var item in result.data["getActiveCountries"]) {
        _countries.add(CountryData.toObject(item));
      }
      provider.setCountry(_countries);
      provider.setLoading(false);
      return;
    }
    provider.setLoading(true);
  }

  @override
  initState() {
    super.initState();

    provider = Provider.of<CountryModel>(context, listen: false);
    _client = GraphQL('https://hagglex-backend-staging.herokuapp.com/graphql')
        .getClient();
    loadData();
  }

  void loadData() async {
    provider.setLoading(true);
    handleResult(await _client.queryCharacter(GraphQL.countriesQuery));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        body: Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/back.png"), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                spacerH(30),
                searchTextField(hint: "Search for country"),
                spacerH(15),
                Divider(
                  color: AppColors.white,
                ),
                Expanded(
                  child:
                      Consumer<CountryModel>(builder: (context, data, child) {
                    return data.loading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: data.countries.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  data.country = data.countries[index];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateAccount()),
                                  );
                                },
                                leading: SvgPicture.network(
                                  data.countries[index].flag,
                                  width: 30.0,
                                  placeholderBuilder: (BuildContext context) =>
                                      Icon(
                                    Icons.flag,
                                    color: AppColors.white,
                                  ),
                                ),
                                title: Text(
                                  "(+${data.countries[index].callingCode}) ${data.countries[index].name}",
                                  style: regular(AppColors.white),
                                ),
                              );
                            });
                  }),
                )
              ],
            ),
          ),
        ));
  }

  // textChanged(t) {
  //   print(t);
  // }
}
