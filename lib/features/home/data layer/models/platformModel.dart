import 'dart:convert';

PlatformMeModel platformMeModelFromMap(String str) =>
    PlatformMeModel.fromMap(json.decode(str));

String platformMeModelToMap(PlatformMeModel data) =>
    json.encode(data.toMap());

class PlatformMeModel {
  User user;

  PlatformMeModel({
    required this.user,
  });

  factory PlatformMeModel.fromMap(Map<String, dynamic> json) =>
      PlatformMeModel(
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
      };
}

class User {
  String uuid;
  String name;
  String email;
  String status;
  List<Profile> profiles;
  List<Permission> permissions;

  User({
    required this.uuid,
    required this.name,
    required this.email,
    required this.status,
    required this.profiles,
    required this.permissions,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        uuid: json["uuid"] ?? "",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        status: json["status"] ?? "",
        profiles: json["profiles"] == null
            ? []
            : List<Profile>.from(
                json["profiles"].map((x) => Profile.fromMap(x)),
              ),
        permissions: json["permissions"] == null
            ? []
            : List<Permission>.from(
                json["permissions"].map((x) => Permission.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "name": name,
        "email": email,
        "status": status,
        "profiles": List<dynamic>.from(profiles.map((x) => x.toMap())),
        "permissions": List<dynamic>.from(permissions.map((x) => x.toMap())),
      };
}

class Profile {
  String uuid;
  String name;
  String code;
  bool? isSuperAdmin;

  Profile({
    required this.uuid,
    required this.name,
    required this.code,
    this.isSuperAdmin,
  });

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        uuid: json["uuid"] ?? "",
        name: json["name"] ?? "",
        code: json["code"] ?? "",
        isSuperAdmin: json["is_super_admin"],
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "name": name,
        "code": code,
        "is_super_admin": isSuperAdmin,
      };
}

class Permission {
  String code;
  String module;
  String action;
  String? description;

  Permission({
    required this.code,
    required this.module,
    required this.action,
    this.description,
  });

  factory Permission.fromMap(Map<String, dynamic> json) => Permission(
        code: json["code"] ?? "",
        module: json["module"] ?? "",
        action: json["action"] ?? "",
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "module": module,
        "action": action,
        "description": description,
      };
}