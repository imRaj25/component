import 'package:haatinhandseller/screens/auth/model/state_model.dart';

class SellerProfileModel {
  String? id;
  String? name;
  String? gender;
  String? countryCode;
  String? mobile;
  String? loginOTP;
  int? likes;
  String? profileImage;
  String? accessToken;
  String? fcmToken;
  bool? hasSubscription;
  bool? isActive;
  bool? isBlocked;
  bool? isDeleted;
  int? createdOn;
  int? updatedOn;
  String? lastSubscriptionID;
  int? planExpireDate;
  bool? hasDeleteRequest;
  int? deleteDate;
  StateModel? state;

  SellerProfileModel(
      {this.id,
      this.name,
      this.gender,
      this.countryCode,
      this.mobile,
      this.loginOTP,
      this.likes,
      this.profileImage,
      this.accessToken,
      this.fcmToken,
      this.hasSubscription,
      this.isActive,
      this.isBlocked,
      this.isDeleted,
      this.createdOn,
      this.updatedOn,
      this.lastSubscriptionID,
      this.planExpireDate,
      this.hasDeleteRequest,
      this.deleteDate,
      this.state});

  SellerProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    loginOTP = json['loginOTP'];
    likes = json['likes'];
    profileImage = json['profileImage'];
    accessToken = json['accessToken'];
    fcmToken = json['fcmToken'];
    hasSubscription = json['hasSubscription'];
    isActive = json['isActive'];
    isBlocked = json['isBlocked'];
    isDeleted = json['isDeleted'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    lastSubscriptionID = json['lastSubscriptionID'];
    planExpireDate = json['planExpireDate'];
    hasDeleteRequest = json['hasDeleteRequest'];
    deleteDate = json['deleteDate'];
    state = json['state'] != null ? StateModel.fromJson(json['state']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['countryCode'] = countryCode;
    data['mobile'] = mobile;
    data['loginOTP'] = loginOTP;
    data['likes'] = likes;
    data['profileImage'] = profileImage;
    data['accessToken'] = accessToken;
    data['fcmToken'] = fcmToken;
    data['hasSubscription'] = hasSubscription;
    data['isActive'] = isActive;
    data['isBlocked'] = isBlocked;
    data['isDeleted'] = isDeleted;
    data['createdOn'] = createdOn;
    data['updatedOn'] = updatedOn;
    data['lastSubscriptionID'] = lastSubscriptionID;
    data['planExpireDate'] = planExpireDate;
    data['hasDeleteRequest'] = hasDeleteRequest;
    data['deleteDate'] = deleteDate;
    if (state != null) {
      data['state'] = state!.toJson();
    }
    return data;
  }
}
