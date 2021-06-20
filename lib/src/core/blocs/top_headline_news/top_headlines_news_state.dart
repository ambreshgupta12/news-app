import 'package:equatable/equatable.dart';
import 'package:news_app/src/data/models/top_headlines_news/articles.dart';

abstract class TopHeadlinesNewsState extends Equatable{
 const TopHeadlinesNewsState();
 @override
 List<Object> get props => [];
}

class InitialTopHeadlinesNewsState extends TopHeadlinesNewsState{}

class LoadingTopHeadlinesNewsState extends TopHeadlinesNewsState{}

class LoadedTopHeadlinesNewsState extends TopHeadlinesNewsState{
 final List<Articles>? articles;
 LoadedTopHeadlinesNewsState({this.articles});
 @override
 List<Object> get props => [articles!];

 @override
 String toString() {
  return 'LoadedTopHeadlinesNewsState{listArticles: $articles}';
 }
}

class ChangeCategoryTopHeadlinesNewsState extends TopHeadlinesNewsState {
 final int? indexCategorySelected;

 ChangeCategoryTopHeadlinesNewsState({required this.indexCategorySelected});

 @override
 List<Object> get props => [indexCategorySelected!];

 @override
 String toString() {
  return 'ChangeCategoryTopHeadlinesNewsState{indexCategorySelected: $indexCategorySelected}';
 }
}



class SearchSuccessTopHeadlinesNewsState extends TopHeadlinesNewsState {
 final List<Articles>? listArticles;

 SearchSuccessTopHeadlinesNewsState({required this.listArticles});

 @override
 List<Object> get props => [listArticles!];

 @override
 String toString() {
  return 'SearchSuccessTopHeadlinesNewsState{listArticles: $listArticles}';
 }
}


class FailureTopHeadlinesNewsState extends TopHeadlinesNewsState{
 final String? errorMsg;
 FailureTopHeadlinesNewsState({this.errorMsg});
 @override
 List<Object> get props => [errorMsg!];

 @override
 String toString() {
  return 'FailureTopHeadlinesNewsState{errorMsg: $errorMsg}';
 }
}