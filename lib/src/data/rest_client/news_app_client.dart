import 'package:dio/dio.dart' hide Headers;
import 'package:news_app/src/constants/url_constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:news_app/src/data/models/top_headlines_news/top_headlines_news_response.dart';

part 'news_app_client.g.dart';

@RestApi()
abstract class NewsAppClient {
  factory NewsAppClient(Dio dio, {required String baseUrl}) = _NewsAppClient;

  @GET(KUrl.topHeadlines)
  @Headers({"Accept": "application/json"})
  @Headers({"Content-type": "application/json"})
  Future<TopHeadlinesNewsResponse> getTopHeadlinesNews(
      {@Query("country") String? country,
      @Query("pageSize") int? pageSize,
      @Query("page") int? page,
      @Query("apiKey") String? apiKey,
      @Query("category") String? category = ''});

  @GET(KUrl.topHeadlines)
  @Headers({"Accept": "application/json"})
  @Headers({"Content-type": "application/json"})
  Future<TopHeadlinesNewsResponse> searchTopHeadlinesNews(
      {@Query("country") String? country,
      @Query("apiKey") String? apiKey,
      @Query("q") String? keyword});
}
