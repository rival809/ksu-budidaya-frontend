import 'package:ksu_budidaya/core.dart';
part 'list_user_model.g.dart';

class ListUserResult {
  bool? success;
  DataListUser? data;
  String? message;

  ListUserResult({this.success, this.data, this.message});

  ListUserResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataListUser.fromJson(json['data']) : null;
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

@HiveType(typeId: 20)
class DataListUser {
  @HiveField(0)
  List<DataUsers>? dataUsers;
  @HiveField(1)
  Paging? paging;

  DataListUser({this.dataUsers, this.paging});

  DataListUser.fromJson(Map<String, dynamic> json) {
    if (json['data_users'] != null) {
      dataUsers = <DataUsers>[];
      json['data_users'].forEach((v) {
        dataUsers!.add(DataUsers.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataUsers != null) {
      data['data_users'] = dataUsers!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 21)
class DataUsers {
  @HiveField(0)
  String? username;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? idRole;
  @HiveField(3)
  String? createdAt;
  @HiveField(4)
  String? updatedAt;

  DataUsers(
      {this.username, this.name, this.idRole, this.createdAt, this.updatedAt});

  String userAsString() {
    return trimString(username);
  }

  DataUsers.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    idRole = json['id_role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['name'] = name;
    data['id_role'] = idRole;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
