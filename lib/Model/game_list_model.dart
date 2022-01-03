class GameListModel {
  List<AppCenter>? appCenter;

  GameListModel({this.appCenter});

  GameListModel.fromJson(Map<String, dynamic> json) {
    if (json['app_center'] != null) {
      appCenter = <AppCenter>[];
      json['app_center'].forEach((v) {
        appCenter!.add(new AppCenter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appCenter != null) {
      data['app_center'] = this.appCenter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppCenter {
  int? id;
  int? position;
  String? name;
  int? isActive;
  String? catgeory;
  List<SubCategory>? subCategory;

  AppCenter(
      {this.id,
        this.position,
        this.name,
        this.isActive,
        this.catgeory,
        this.subCategory});

  AppCenter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
    name = json['name'];
    isActive = json['is_active'];
    catgeory = json['catgeory'];
    if (json['sub_category'] != null) {
      subCategory = <SubCategory>[];
      json['sub_category'].forEach((v) {
        subCategory!.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position'] = this.position;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['catgeory'] = this.catgeory;
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  int? id;
  int? appId;
  int? position;
  String? name;
  String? icon;
  String? star;
  String? installedRange;
  String? appLink;
  String? banner;
  int? isActive;
  int? imageActive;
  String? bannerImage;

  SubCategory(
      {this.id,
        this.appId,
        this.position,
        this.name,
        this.icon,
        this.star,
        this.installedRange,
        this.appLink,
        this.banner,
        this.isActive,
        this.imageActive,
        this.bannerImage});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    position = json['position'];
    name = json['name'];
    icon = json['icon'];
    star = json['star'];
    installedRange = json['installed_range'];
    appLink = json['app_link'];
    banner = json['banner'];
    isActive = json['is_active'];
    imageActive = json['image_active'];
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_id'] = this.appId;
    data['position'] = this.position;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['star'] = this.star;
    data['installed_range'] = this.installedRange;
    data['app_link'] = this.appLink;
    data['banner'] = this.banner;
    data['is_active'] = this.isActive;
    data['image_active'] = this.imageActive;
    data['banner_image'] = this.bannerImage;
    return data;
  }
}
