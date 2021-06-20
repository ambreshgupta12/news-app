import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/src/constants/url_constants.dart';
import 'package:news_app/src/core/error/failure.dart';
import 'package:news_app/src/core/network/network_info.dart';
import 'package:news_app/src/data/rest_client/news_app_client.dart';
import 'package:news_app/src/di/app_initializer.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:news_app/src/data/models/top_headlines_news/top_headlines_news_response.dart';

class NewsAppRepository {
  NewsAppClient? apiClient;
  final NetworkInfo networkInfo = AppInitializer.getIt<NetworkInfo>();

  NewsAppRepository() {
    final _dio = Dio();
    if (kDebugMode) {
      _dio.options = BaseOptions(validateStatus: (val) => true);
      _dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: false,
          compact: true,
          maxWidth: 90));
    }
    apiClient = NewsAppClient(_dio, baseUrl: KUrl.baseURL);
  }

  Future<Either<Failure, TopHeadlinesNewsResponse>> getTopHeadlinesNews({String? country, int? pageSize, int? page, String? apiKey, String? category}) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await apiClient!.getTopHeadlinesNews(
            country: country,
            page: page,
            pageSize: pageSize,
            category: category,
            apiKey: apiKey);
        return Right(response);
      } on DioError catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


  Future<Either<Failure, TopHeadlinesNewsResponse>> getSearchTopHeadlinesNews({String? country, String? apiKey, String? keyword}) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await apiClient!.searchTopHeadlinesNews(
            country: country,
            keyword: keyword,
            apiKey: apiKey
        );
        return Right(response);
      } on DioError catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

}
