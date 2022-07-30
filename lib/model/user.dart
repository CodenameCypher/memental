class UserModel{
  String name;
  String password;
  String role;
  String email;
  bool isActivated;
  String uid;

  UserModel({required this.email, required this.password, required this.name, required this.role, required this.isActivated, required this.uid});
}