class User {
  int? userID;
  String? email, name, phone, profileImage;
  bool? isActive, isSuperAdmin, isControlAcc = false;
  String? lastModifiedDateTime, createdDateTime;
  int? lastModifiedUserID, createdUserID;

  User(
      {this.userID,
      this.email,
      this.name,
      this.phone,
      this.profileImage,
      this.isActive,
      this.isSuperAdmin,
      this.isControlAcc,
      this.lastModifiedDateTime,
      this.lastModifiedUserID,
      this.createdDateTime,
      this.createdUserID});

  User.fromJson(Map<String, dynamic> json) {
    userID = json["userID"];
    email = json["email"];
    name = json["name"];
    phone = json["phone"];
    profileImage = json["profileImage"];
    isActive = json["isActive"];
    isSuperAdmin = json["isSuperAdmin"];
    isControlAcc = json["isControlAcc"];
    lastModifiedDateTime = json["lastModifiedDateTime"];
    lastModifiedUserID = json["lastModifiedUserID"];
    createdDateTime = json["createdDateTime"];
    createdUserID = json["createdUserID"];
  }
}
