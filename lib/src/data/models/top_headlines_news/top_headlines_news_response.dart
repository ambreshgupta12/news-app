import 'package:json_annotation/json_annotation.dart';

import 'articles.dart';

part 'top_headlines_news_response.g.dart';

@JsonSerializable()
class TopHeadlinesNewsResponse {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  TopHeadlinesNewsResponse({this.status, this.totalResults, this.articles});

  factory TopHeadlinesNewsResponse.fromJson(Map<String, dynamic> json) => _$TopHeadlinesNewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopHeadlinesNewsResponseToJson(this);
}
