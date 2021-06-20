import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/core/blocs/top_headline_news/top_headlines_news_event.dart';
import 'package:news_app/src/core/blocs/top_headline_news/top_headlines_news_state.dart';
import 'package:news_app/src/core/error/failure.dart';
import 'package:news_app/src/data/repositories/news_app_repository.dart';
import 'package:news_app/src/di/app_initializer.dart';

class TopHeadlinesNewsBloc
    extends Bloc<TopHeadlinesNewsEvent, TopHeadlinesNewsState> {
  final newsAppRepository = AppInitializer.getIt<NewsAppRepository>();

  TopHeadlinesNewsBloc() : super(InitialTopHeadlinesNewsState());

  @override
  Stream<TopHeadlinesNewsState> mapEventToState(
      TopHeadlinesNewsEvent event) async* {
    if (event is LoadTopHeadlinesNewsEvent) {
      yield* _mapLoadTopHeadlinesNewsEventToState(event);
    }
    else if (event is ChangeCategoryTopHeadlinesNewsEvent) {
      yield ChangeCategoryTopHeadlinesNewsState(
          indexCategorySelected: event.indexCategorySelected);
    }
    else if (event is SearchTopHeadlinesNewsEvent) {
      yield* _mapSearchTopHeadlinesNewsEventToState(event);
    }
  }

  Stream<TopHeadlinesNewsState> _mapLoadTopHeadlinesNewsEventToState(
      LoadTopHeadlinesNewsEvent loadTopHeadlinesNewsEvent) async* {
    yield LoadingTopHeadlinesNewsState();
    var response = await newsAppRepository.getTopHeadlinesNews(
      apiKey: loadTopHeadlinesNewsEvent.apiKey,
      country: loadTopHeadlinesNewsEvent.country,
      category: loadTopHeadlinesNewsEvent.category,
      page: loadTopHeadlinesNewsEvent.page,
      pageSize: loadTopHeadlinesNewsEvent.pageSize,
    );
    yield* response.fold((failure) async* {
      if (failure is ServerFailure) {
        yield FailureTopHeadlinesNewsState(errorMsg: failure.errorMessage);
      } else if (failure is ConnectionFailure) {
        yield FailureTopHeadlinesNewsState(errorMsg: failure.errorMessage);
      }
    }, (data) async* {
      yield LoadedTopHeadlinesNewsState(articles: data.articles);
    });
  }

  Stream<TopHeadlinesNewsState> _mapSearchTopHeadlinesNewsEventToState(
      SearchTopHeadlinesNewsEvent event) async* {
    yield LoadingTopHeadlinesNewsState();
    var response = await newsAppRepository.getSearchTopHeadlinesNews(
        apiKey: event.apiKey!,
        country: event.country,
        keyword: event.keyword

    );
    yield* response.fold((failure) async* {
      if (failure is ServerFailure) {
        yield FailureTopHeadlinesNewsState(errorMsg: failure.errorMessage);
      } else if (failure is ConnectionFailure) {
        yield FailureTopHeadlinesNewsState(errorMsg: failure.errorMessage);
      }
    }, (data) async* {
      yield SearchSuccessTopHeadlinesNewsState(listArticles: data.articles);
    });
  }


}
