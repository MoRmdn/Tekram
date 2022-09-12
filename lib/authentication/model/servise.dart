import 'dart:convert';

import 'package:tekram/authentication/model/user.dart';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service(
      {this.users,
      required this.address,
      this.titel,
      this.descreption,
      this.state,
      this.help});

  Users? users;
  Address address;
  String? titel;
  String? descreption;
  int? state;
  Users? help;
  factory Service.fromJson(Map json) => Service(
        users: Users.fromJson(json["Users"]),
        address: Address.fromJson(json["Address"]),
        descreption: json["descreption"],
        titel: json["titel"],
        state: json['state'],
        help: Users.fromJson(json["help"]),
      );

  Map<String, dynamic> toJson() => {
        "Users": users?.toJson(),
        "Address": address.toJson(),
        "descreption": descreption,
        "titel": titel,
        "state": state,
        'help': users?.toJson(),
      };
}

class Address {
  Address({
    this.lat,
    this.log,
  });

  double? lat;
  double? log;

  factory Address.fromJson(Map json) => Address(
        lat: json["Lat"],
        log: json["log"],
      );

  Map<String, dynamic> toJson() => {
        "Lat": lat,
        "log": log,
      };
}
