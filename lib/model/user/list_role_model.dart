class ListRoleResult {
  bool? success;
  DataListRole? data;
  String? message;

  ListRoleResult({this.success, this.data, this.message});

  ListRoleResult.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? DataListRole.fromJson(json['data']) : null;
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

class DataListRole {
  List<dynamic>? dataRoles;
  Paging? paging;

  DataListRole({this.dataRoles, this.paging});

  DataListRole.fromJson(Map<String, dynamic> json) {
    dataRoles = json['data_roles'];
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data_roles'] = dataRoles;
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    return data;
  }
}

class Paging {
  int? page;
  int? totalItem;
  int? totalPage;

  Paging({this.page, this.totalItem, this.totalPage});

  Paging.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalItem = json['total_item'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['total_item'] = totalItem;
    data['total_page'] = totalPage;
    return data;
  }
}
