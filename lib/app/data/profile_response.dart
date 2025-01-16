class ProfileResponse {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? avatar;

  ProfileResponse(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.avatar});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['avatar'] = this.avatar;
    return data;
  }
}