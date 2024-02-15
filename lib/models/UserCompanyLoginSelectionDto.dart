import 'dart:convert';

class UserCompanyLoginSelectionDto {
  int? userMappingID;
  int? userTypeID;
  String? type;
  int? companyID;
  late String companyName;
  bool? isDeletedTemporarily = false;

  UserCompanyLoginSelectionDto(
      {this.userMappingID,
      this.userTypeID,
      this.type,
      this.companyID,
      required this.companyName,
      this.isDeletedTemporarily});

  // static String serialize(UserCompanyLoginSelectionDto model) =>json.encode(UserCompanyLoginSelectionDto.toJson(model, ""));
  static List<UserCompanyLoginSelectionDto> userFromJson(String str) =>
      List<UserCompanyLoginSelectionDto>.from(json.decode(str).map(
          (x) => UserCompanyLoginSelectionDto.fromJson(x, "Select Company")));

  static String userToJson(List<UserCompanyLoginSelectionDto> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  static String serialize(UserCompanyLoginSelectionDto data) =>
      json.encode(UserCompanyLoginSelectionDto.toMap(data));

  static UserCompanyLoginSelectionDto deserialize(String json) =>
      UserCompanyLoginSelectionDto.fromJson2(jsonDecode(json));

  UserCompanyLoginSelectionDto.fromJson(
      Map<String, dynamic> json, this.companyName) {
    userMappingID = json["userMappingID"];
    userTypeID = json["userTypeID"];
    type = json["type"];
    companyID = json["companyID"];
    companyName = json["companyName"];
    isDeletedTemporarily = json["isDeletedTemporarily"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userMappingID'] = this.userMappingID;
    data['userTypeID'] = this.userTypeID;
    data['type'] = this.type;
    data['companyID'] = this.companyID;
    data['companyName'] = this.companyName;
    data['isDeletedTemporarily'] = this.isDeletedTemporarily;
    return data;
  }

  static Map<String, dynamic> toMap(UserCompanyLoginSelectionDto model) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userMappingID'] = model.userMappingID;
    data['userTypeID'] = model.userTypeID;
    data['type'] = model.type;
    data['companyID'] = model.companyID;
    data['companyName'] = model.companyName;
    data['isDeletedTemporarily'] = model.isDeletedTemporarily;
    return data;
  }

  factory UserCompanyLoginSelectionDto.fromJson2(Map<String, dynamic> json) =>
      UserCompanyLoginSelectionDto(
        userMappingID: json["userMappingID"],
        userTypeID: json["userTypeID"],
        type: json["type"],
        companyID: json["companyID"],
        companyName: json["companyName"],
        isDeletedTemporarily: json["isDeletedTemporarily"],
      );

  // Map<String, dynamic> toJson() => {
  //       "userMappingID": userMappingID,
  //       "userTypeID": userTypeID,
  //       "type": type,
  //       "companyID": companyID,
  //       "companyName": companyName,
  //       "isDeletedTemporarily": isDeletedTemporarily,
  //     };
}
