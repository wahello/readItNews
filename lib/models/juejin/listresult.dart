import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

enum JuejinCategory {
  Recommend, //推荐
}

class ListData {
  List<Edges> list;
  String last;
  ListData(this.list, this.last);
}

@JsonSerializable()
class ListResult {
  Data data;

  ListResult({this.data});

  ListResult.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
  factory ListResult.fromJsonStr(String json) {
    return ListResult.fromJson(jsonDecode(json));
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  ArticleFeed articleFeed;

  Data({this.articleFeed});

  Data.fromJson(Map<String, dynamic> json) {
    articleFeed = json['articleFeed'] != null
        ? new ArticleFeed.fromJson(json['articleFeed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articleFeed != null) {
      data['articleFeed'] = this.articleFeed.toJson();
    }
    return data;
  }
}

class ArticleFeed {
  Items items;

  ArticleFeed({this.items});

  ArticleFeed.fromJson(Map<String, dynamic> json) {
    items = json['items'] != null ? new Items.fromJson(json['items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.toJson();
    }
    return data;
  }
}

class Items {
  List<Edges> edges;
  PageInfo pageInfo;

  Items({this.edges, this.pageInfo});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = new List<Edges>();
      json['edges'].forEach((v) {
        edges.add(new Edges.fromJson(v));
      });
    }
    pageInfo = json['pageInfo'] != null
        ? new PageInfo.fromJson(json['pageInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edges != null) {
      data['edges'] = this.edges.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo.toJson();
    }
    return data;
  }
}

class Edges {
  Node node;

  Edges({this.node});

  Edges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new Node.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node.toJson();
    }
    return data;
  }
}

class Node {
  String id;
  int commentsCount;
  bool hot;
  double hotIndex;
  bool original;
  String originalUrl;
  double rankIndex;
  String screenshot;
  Null summaryInfo;
  List<Tags> tags;
  String title;
  String type;
  User user;
  String lastCommentTime;
  int likeCount;
  Null eventInfo;
  bool viewerHasLiked;
  String createdAt;
  String updatedAt;
  String content;

  Node(
      {this.id,
      this.commentsCount,
      this.hot,
      this.hotIndex,
      this.original,
      this.originalUrl,
      this.rankIndex,
      this.screenshot,
      this.summaryInfo,
      this.tags,
      this.title,
      this.type,
      this.user,
      this.lastCommentTime,
      this.likeCount,
      this.eventInfo,
      this.viewerHasLiked,
      this.createdAt,
      this.updatedAt,
      this.content});

  Node.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentsCount = json['commentsCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    content = json['content'];
    originalUrl = json['originalUrl'];
    title = json['title'];
    hot = json['hot'];
    hotIndex = json['hotIndex'];
    original = json['original'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    viewerHasLiked = json['viewerHasLiked'];

    try {
      likeCount = json['likeCount'];
      rankIndex = json['rankIndex'];
      screenshot = json['screenshot'];
      summaryInfo = json['summaryInfo'];
      if (json['tags'] != null) {
        tags = new List<Tags>();
        json['tags'].forEach((v) {
          tags.add(new Tags.fromJson(v));
        });
      }

      type = json['type'];

      lastCommentTime = json['lastCommentTime'];

      eventInfo = json['eventInfo'];
    } catch (ex) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['commentsCount'] = this.commentsCount;
    data['hot'] = this.hot;
    data['hotIndex'] = this.hotIndex;
    data['original'] = this.original;
    data['originalUrl'] = this.originalUrl;
    data['rankIndex'] = this.rankIndex;
    data['screenshot'] = this.screenshot;
    data['summaryInfo'] = this.summaryInfo;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['type'] = this.type;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['lastCommentTime'] = this.lastCommentTime;
    data['likeCount'] = this.likeCount;
    data['eventInfo'] = this.eventInfo;
    data['viewerHasLiked'] = this.viewerHasLiked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['content'] = this.content;
    return data;
  }
}

class Tags {
  String id;
  String title;

  Tags({this.id, this.title});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class User {
  String id;
  String role;
  String username;
  String avatarLarge;

  User({this.id, this.role, this.username, this.avatarLarge});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    username = json['username'];
    avatarLarge = json['avatarLarge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['username'] = this.username;
    data['avatarLarge'] = this.avatarLarge;
    return data;
  }
}

class PageInfo {
  bool hasNextPage;
  String endCursor;

  PageInfo({this.hasNextPage, this.endCursor});

  PageInfo.fromJson(Map<String, dynamic> json) {
    hasNextPage = json['hasNextPage'];
    endCursor = json['endCursor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasNextPage'] = this.hasNextPage;
    data['endCursor'] = this.endCursor;
    return data;
  }
}
