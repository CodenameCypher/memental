class UserModel{
  String name;
  String password;
  String role;
  String email;
  String number;
  String age;
  String speciality;
  bool isActivated;
  String uid;

  UserModel({required this.email, required this.password, required this.name, required this.role, required this.number, required this.age, required this.speciality, required this.isActivated, required this.uid});

  void printDetails(){
    print(this.uid);
    print(this.name);
    print(this.email);
    print(this.password);
    print(this.role);
    print(this.isActivated);
  }
}