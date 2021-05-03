import 'package:graphql/client.dart';
import 'package:hagglex/AppEngine/model.dart';

class GraphQL {
  final baseURL;

  static final String registerMutation = r"""
        mutation Register($code:String!,$country:String!,$currency:String!,$ref:String!, $flag:String!,$email:String!,$username:String!,$pwd:String!,$phone:String!){
            action:register(data:{
              email: $email,
              username: $username,
              password:$pwd,
              phonenumber:$phone,
              referralCode:$ref,
              phoneNumberDetails:{
                flag:$flag,
                callingCode:$code,
                phoneNumber:$phone
              },
              country:$country,
              currency:$currency
            }){
              
              token
            }
            }
            """;

  static final String verifyMutation = r"""
        mutation VerifyUser($code:Int!){
              action:verifyUser(data:{
                code: $code,
              }){
                
                token
              }
              }
            """;

  static final String countriesQuery = r"""
          query getCountries{
              getActiveCountries{
                name,
                currencyCode,
                flag,
                callingCode
                }
              }
    """;

  GraphQL(this.baseURL);

  GraphQLClient getClient({token = ""}) => GraphQLClient(
        cache: InMemoryCache(storagePrefix: ''),
        link: HttpLink(
            uri: baseURL,
            headers: {"Authorization": "Bearer " + token}).concat(null),
      );
}

extension Graph on GraphQLClient {
  Future queryCharacter(readCharacter) {
    return this.query(
      QueryOptions(
        documentNode: gql(readCharacter),
      ),
    );
  }

  Future mutateCharacter(registerMutation, UserData user) {
    return this.mutate(
      MutationOptions(documentNode: gql(registerMutation), variables: {
        "flag": user.flag,
        "country": user.country,
        "code": user.callingCode,
        "currency": user.currency,
        "ref": user.referralCode,
        "email": user.email,
        "username": user.username,
        "pwd": user.password,
        "phone": user.phonenumber
      }),
    );
  }

  Future mutateVerify(int code) {
    return this.mutate(
      MutationOptions(documentNode: gql(r"""mutation VerifyUser($code:Int!){
              action:verifyUser(data:{code: $code,}){ token }}
            """), variables: {
        "code": code,
      }),
    );
  }

  Future mutateLogin(UserData user) {
    return this.mutate(
      MutationOptions(
          documentNode: gql(r"""mutation login($email:String!,$pwd:String!){
                              login(data:{password:$email, input:$pwd}){
                                user{
                                  phonenumber
                                }
                              }
                            }
            """),
          variables: {
            "email": user.email,
            "pwd": user.password,
          }),
    );
  }

  Future queryVerify(String email) {
    return this.query(
      QueryOptions(documentNode: gql(r"""query getVerifyCode{
                  resendVerificationCode(data:{email:$email})
                }
            """), variables: {
        "email": email,
      }),
    );
  }
}
