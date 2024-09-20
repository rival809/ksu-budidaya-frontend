class DetailUserResult {
  bool? success;
  DataDetailUser? data;
  String? message;

  DetailUserResult({this.success, this.data, this.message});

  DetailUserResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataDetailUser.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class DataDetailUser {
  String? username;
  String? name;
  String? token;
  String? idRole;
  String? password;
  String? createdAt;
  String? updatedAt;

  DataDetailUser(
      {this.username,
      this.name,
      this.token,
      this.idRole,
      this.password,
      this.createdAt,
      this.updatedAt});

  DataDetailUser copyWith({
    String? username,
    String? name,
    String? token,
    String? idRole,
    String? password,
    String? createdAt,
    String? updatedAt,
  }) =>
      DataDetailUser(
        username: username ?? this.username,
        name: name ?? this.name,
        token: token ?? this.token,
        idRole: idRole ?? this.idRole,
        password: password ?? this.password,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  DataDetailUser.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    token = json['token'];
    idRole = json['id_role'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['name'] = name;
    data['token'] = token;
    data['id_role'] = idRole;
    data['password'] = password;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
