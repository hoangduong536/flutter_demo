

class UserData {
  String displayName;
  String email;


  UserData({this.email,this.displayName});

  factory UserData.fromData(String email,String displayName ) {
    return UserData(
      email: email,
      displayName: displayName
    );
  }
}