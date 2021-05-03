import 'package:flutter/foundation.dart';
import 'package:hagglex/AppEngine/model.dart';

class CountryModel extends ChangeNotifier {
  /// Internal, private state of the cart.

  bool _loading = true;
  bool get loading => _loading;

  final List<CountryData> _countryData = [];
  List<CountryData> get countries => _countryData;

  UserData user = UserData();

  String token;
  //UserData get userData => _user;

  CountryData country;

  void setCountry(List<CountryData> countries) {
    _countryData.clear();
    _countryData.addAll(countries);
    notifyListeners();
  }

  void addCountry(CountryData country) {
    _countryData.add(country);
    notifyListeners();
  }

  void setLoading(bool state) {
    _loading = state;
    notifyListeners();
  }
}
