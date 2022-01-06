class User {
  String? name;
  String? id;
  String? email;
  String? number;

  User({this.name, this.id, this.email, this.number});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        name: json["name"],
        id: json["id"],
        email: json["email"],
        number: json["number"]);
  }

  Map<String, dynamic> toJson() => _userToJson(this);

  Map<String, dynamic> _userToJson(User instance) => <String, dynamic>{
        'name': instance.name,
        'id': instance.id,
        'email': instance.email,
        'number': instance.number,
      };
}
