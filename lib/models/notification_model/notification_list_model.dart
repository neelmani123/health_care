class NotificationListModel {
  bool? result;
  var message;
  List<NotificationList>? notificationList;
  var page;

  NotificationListModel(
      {this.result, this.message, this.notificationList, this.page});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['notification_list'] != null) {
      notificationList = <NotificationList>[];
      json['notification_list'].forEach((v) {
        notificationList!.add(new NotificationList.fromJson(v));
      });
    }
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.notificationList != null) {
      data['notification_list'] =
          this.notificationList!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    return data;
  }
}

class NotificationList {
  var id;
  var name;
  var userId;
  var hospitalId;
  var title;
  var image;
  var description;
  var type;
  var role;
  var date;
  var isSent;
  var status;
  var createdAt;
  var updatedAt;

  NotificationList(
      {this.id,
        this.name,
        this.userId,
        this.hospitalId,
        this.title,
        this.image,
        this.description,
        this.type,
        this.role,
        this.date,
        this.isSent,
        this.status,
        this.createdAt,
        this.updatedAt});

  NotificationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    hospitalId = json['hospital_id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    type = json['type'];
    role = json['role'];
    date = json['date'];
    isSent = json['is_sent'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['hospital_id'] = this.hospitalId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['type'] = this.type;
    data['role'] = this.role;
    data['date'] = this.date;
    data['is_sent'] = this.isSent;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
