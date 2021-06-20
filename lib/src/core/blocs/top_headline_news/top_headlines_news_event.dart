import 'package:equatable/equatable.dart';

abstract class TopHeadlinesNewsEvent extends Equatable {
  const TopHeadlinesNewsEvent();
}

class LoadTopHeadlinesNewsEvent extends TopHeadlinesNewsEvent {
  final String? category;
  final String? country;
  final int? pageSize;
  final int? page;
  final String? apiKey;
  LoadTopHeadlinesNewsEvent({required this.category, required this.country, this.pageSize,  this.page, required this.apiKey});
  @override
  List<Object?> get props => [category,apiKey,page,pageSize,apiKey];
}

class ChangeCategoryTopHeadlinesNewsEvent extends TopHeadlinesNewsEvent {
  final int indexCategorySelected;

  ChangeCategoryTopHeadlinesNewsEvent({required this.indexCategorySelected});

  @override
  List<Object> get props => [indexCategorySelected];

  @override
  String toString() {
    return 'ChangeCategoryTopHeadlinesNewsEvent{indexCategorySelected: $indexCategorySelected}';
  }
}

class SearchTopHeadlinesNewsEvent extends TopHeadlinesNewsEvent {
  final String? keyword;
  final String? country;
  final String? apiKey;
  SearchTopHeadlinesNewsEvent({required this.keyword,required this.country,required this.apiKey});

  @override
  List<Object> get props => [keyword!,country!,apiKey!];

}

