// To parse this JSON data, do
//
//     final getBook = getBookFromJson(jsonString);

import 'dart:convert';

List<GetBook> getBookFromJson(String str) => List<GetBook>.from(json.decode(str).map((x) => GetBook.fromJson(x)));

String getBookToJson(List<GetBook> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBook {
  GetBook({
    this.id,
    this.nickname,
    this.name,
    this.tel,
    this.avatar,
    this.idLine,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String nickname;
  final String name;
  final String tel;
  final dynamic avatar;
  final String idLine;
  final dynamic createdAt;
  final dynamic updatedAt;

  GetBook copyWith({
    int id,
    String nickname,
    String name,
    String tel,
    dynamic avatar,
    String idLine,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      GetBook(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        name: name ?? this.name,
        tel: tel ?? this.tel,
        avatar: avatar ?? this.avatar,
        idLine: idLine ?? this.idLine,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory GetBook.fromJson(Map<String, dynamic> json) => GetBook(
    id: json["id"],
    nickname: json["nickname"],
    name: json["name"],
    tel: json["tel"],
    avatar: json["avatar"],
    idLine: json["id_line"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nickname": nickname,
    "name": name,
    "tel": tel,
    "avatar": avatar,
    "id_line": idLine,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
