import 'dart:convert';

class UserCompanyLoginSelectionDto {
  int? userMappingID;
  int? userTypeID;
  String? type;
  int? companyID;
  late String comapanyName;
  bool? isActive = false;

  UserCompanyLoginSelectionDto(
      {this.userMappingID,
      this.userTypeID,
      this.type,
      this.companyID,
      required this.comapanyName,
      this.isActive});

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
      Map<String, dynamic> json, this.comapanyName) {
    userMappingID = json["userMappingID"];
    userTypeID = json["userTypeID"];
    type = json["type"];
    companyID = json["companyID"];
    comapanyName = json["comapanyName"];
    isActive = json["isActive"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userMappingID'] = this.userMappingID;
    data['userTypeID'] = this.userTypeID;
    data['type'] = this.type;
    data['companyID'] = this.companyID;
    data['comapanyName'] = this.comapanyName;
    data['isActive'] = this.isActive;
    return data;
  }

  static Map<String, dynamic> toMap(UserCompanyLoginSelectionDto model) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userMappingID'] = model.userMappingID;
    data['userTypeID'] = model.userTypeID;
    data['type'] = model.type;
    data['companyID'] = model.companyID;
    data['comapanyName'] = model.comapanyName;
    data['isActive'] = model.isActive;
    return data;
  }

  factory UserCompanyLoginSelectionDto.fromJson2(Map<String, dynamic> json) =>
      UserCompanyLoginSelectionDto(
        userMappingID: json["userMappingID"],
        userTypeID: json["userTypeID"],
        type: json["type"],
        companyID: json["companyID"],
        comapanyName: json["comapanyName"],
        isActive: json["isActive"],
      );

  // Map<String, dynamic> toJson() => {
  //       "userMappingID": userMappingID,
  //       "userTypeID": userTypeID,
  //       "type": type,
  //       "companyID": companyID,
  //       "comapanyName": comapanyName,
  //       "isActive": isActive,
  //     };
}
