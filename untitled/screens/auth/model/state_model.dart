class StateModel {
  String? id;
  String? name;
  bool? isActive;
  bool? isDeleted;
  int? createdOn;
  int? updatedOn;

  StateModel(
      {this.id,
      this.name,
      this.isActive,
      this.isDeleted,
      this.createdOn,
      this.updatedOn});

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    data['createdOn'] = createdOn;
    data['updatedOn'] = updatedOn;
    return data;
  }
}
