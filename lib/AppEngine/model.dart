class CountryData {
  String name;
  String currencyCode;
  String flag;
  String callingCode;

  CountryData(
    this.name,
    this.currencyCode,
    this.flag,
    this.callingCode,
  );

  factory CountryData.toObject(Map<String, dynamic> json) => CountryData(
        json['name'],
        json['currencyCode'],
        json['flag'],
        json['callingCode'],
      );
}

class UserData {
  String email;
  String username;
  String password;
  String phonenumber;
  String referralCode;
  String callingCode;
  String flag;
  String country;
  String currency;
  int verifyCode;

  // UserData(
  //   this.email,
  //   this.username,
  //   this.password,
  //   this.phonenumber,
  //   this.referralCode,
  //   this.callingCode,
  //   this.flag,
  //   this.country,
  //   this.currency,
  // );

  // factory UserData.toObject(Map<String, dynamic> json) => UserData(
  //       json['name'],
  //       json['currencyCode'],
  //       json['flag'],
  //       json['callingCode'],
  //     );
}
