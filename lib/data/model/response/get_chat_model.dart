// To parse this JSON data, do
//
//     final getChatModel = getChatModelFromJson(jsonString);

import 'dart:convert';

GetChatModel getChatModelFromJson(String str) => GetChatModel.fromJson(json.decode(str));

String getChatModelToJson(GetChatModel data) => json.encode(data.toJson());

class GetChatModel {
    GetChatModel({
        this.conversation,
    });

    List<Conversation> conversation;

    factory GetChatModel.fromJson(Map<String, dynamic> json) => GetChatModel(
        conversation: List<Conversation>.from(json["conversation"].map((x) => Conversation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "conversation": List<dynamic>.from(conversation.map((x) => x.toJson())),
    };
}

class Conversation {
    Conversation({
        this.id,
        this.userId,
        this.orderId,
        this.message,
        this.riderMsg,
        this.reply,
        this.checked,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int userId;
    int orderId;
    String message;
    String riderMsg;
    String reply;
    int checked;
    String image;
    DateTime createdAt;
    DateTime updatedAt;

    factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        message: json["message"] == null ? null : json["message"],
        riderMsg: json["rider_msg"] == null ? null : json["rider_msg"],
        reply: json["reply"] == null ? null : json["reply"],
        checked: json["checked"],
        image: json["image"]== null ? null : json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "message": message == null ? null : message,
        "rider_msg": riderMsg == null ? null : riderMsg,
        "reply": reply == null ? null : reply,
        "checked": checked,
        "image": image== null ? null : image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
