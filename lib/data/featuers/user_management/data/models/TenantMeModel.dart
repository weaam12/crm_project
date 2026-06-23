import 'dart:convert';

TenantMeModel tenantMeModelFromMap(String str) =>
    TenantMeModel.fromMap(json.decode(str));

String tenantMeModelToMap(TenantMeModel data) =>
    json.encode(data.toMap());

class TenantMeModel {
  Tenant? tenant;
  User? user;
  List<Permission>? permissions;

  TenantMeModel({
    this.tenant,
    this.user,
    this.permissions,
  });

  factory TenantMeModel.fromMap(Map<String, dynamic> json) => TenantMeModel(
        tenant: json["tenant"] != null
            ? Tenant.fromMap(json["tenant"])
            : null,
        user: json["user"] != null
            ? User.fromMap(json["user"])
            : null,
        permissions: json["user"]?["permissions"] != null
            ? List<Permission>.from(
                json["user"]["permissions"]
                    .map((x) => Permission.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "tenant": tenant?.toMap(),
        "user": user?.toMap(),
        "permissions": permissions != null
            ? List<dynamic>.from(permissions!.map((x) => x.toMap()))
            : [],
      };
}

class Permission {
  String? code;
  String? module;
  String? action;

  Permission({
    this.code,
    this.module,
    this.action,
  });

  factory Permission.fromMap(Map<String, dynamic> json) => Permission(
        code: json["code"]?.toString(),
        module: json["module"]?.toString(),
        action: json["action"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "module": module,
        "action": action,
      };
}

class Profile {
  String? uuid;
  String? name;
  String? code;

  Profile({
    this.uuid,
    this.name,
    this.code,
  });

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        uuid: json["uuid"]?.toString(),
        name: json["name"]?.toString(),
        code: json["code"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "name": name,
        "code": code,
      };
}

class Tenant {
  String? uuid;
  String? slug;
  String? name;

  Tenant({
    this.uuid,
    this.slug,
    this.name,
  });

  factory Tenant.fromMap(Map<String, dynamic> json) => Tenant(
        uuid: json["uuid"]?.toString(),
        slug: json["slug"]?.toString(),
        name: json["name"]?.toString(),
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "slug": slug,
        "name": name,
      };
}

class User {
  String? uuid;
  String? username;
  String? name;
  String? status;
  Profile? role;
  Profile? profile;

  User({
    this.uuid,
    this.username,
    this.name,
    this.status,
    this.role,
    this.profile,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        uuid: json["uuid"]?.toString(),
        username: json["username"]?.toString(),
        name: json["name"]?.toString(),
        status: json["status"]?.toString(),
        role: json["role"] != null
            ? Profile.fromMap(json["role"])
            : null,
        profile: json["profile"] != null
            ? Profile.fromMap(json["profile"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "username": username,
        "name": name,
        "status": status,
        "role": role?.toMap(),
        "profile": profile?.toMap(),
      };
}