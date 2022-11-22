class TodoModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? color;
  String? avatar;

  TodoModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.color,
      this.avatar});

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    color = json['color'];
    avatar = json['avatar'];
  }

  int get changeColorValue {
    var newColors = color?.replaceFirst("#", "0xff");
    return int.tryParse(newColors ?? "") ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['color'] = color;
    data['avatar'] = avatar;
    return data;
  }
}
