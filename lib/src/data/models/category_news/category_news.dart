import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'category_news.g.dart';

@JsonSerializable()
class CategoryNews{
  final String? image;
  final String? title;

  CategoryNews({
    @required this.image,
    @required this.title,
  });

  factory CategoryNews.fromJson(Map<String, dynamic> json) => _$CategoryNewsFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryNewsToJson(this);

}
