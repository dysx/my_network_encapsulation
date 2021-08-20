class Article {
  int? id;
  String? title;
  int? userId;
  String? nickName;
  String? avatarUrl;
  String? date;
  List? images;
  int? visitNum;
  int? likeNum;
  int? commentNum;
  bool? isLike;
  bool? isFollow;
  int? contentType;
  bool? isMyself;
  int? duration;

  Article(
      {this.id,
        this.title,
        this.userId,
        this.nickName,
        this.avatarUrl,
        this.date,
        this.images,
        this.visitNum,
        this.likeNum,
        this.commentNum,
        this.isLike,
        this.isFollow,
        this.contentType,
        this.isMyself,
        this.duration});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userId = json['userId'];
    nickName = json['nickName'];
    avatarUrl = json['avatarUrl'];
    date = json['date'];
    images = json['images'];
    visitNum = json['visitNum'];
    likeNum = json['likeNum'];
    commentNum = json['commentNum'];
    isLike = json['isLike'];
    isFollow = json['isFollow'];
    contentType = json['contentType'];
    isMyself = json['isMyself'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['userId'] = this.userId;
    data['nickName'] = this.nickName;
    data['avatarUrl'] = this.avatarUrl;
    data['date'] = this.date;
    data['images'] = this.images;
    data['visitNum'] = this.visitNum;
    data['likeNum'] = this.likeNum;
    data['commentNum'] = this.commentNum;
    data['isLike'] = this.isLike;
    data['isFollow'] = this.isFollow;
    data['contentType'] = this.contentType;
    data['isMyself'] = this.isMyself;
    data['duration'] = this.duration;
    return data;
  }
}