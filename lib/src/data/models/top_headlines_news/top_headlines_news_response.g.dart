// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_headlines_news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopHeadlinesNewsResponse _$TopHeadlinesNewsResponseFromJson(
    Map<String, dynamic> json) {
  return TopHeadlinesNewsResponse(
    status: json['status'] as String?,
    totalResults: json['totalResults'] as int?,
    articles: (json['articles'] as List<dynamic>?)
        ?.map((e) => Articles.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TopHeadlinesNewsResponseToJson(
        TopHeadlinesNewsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };
