import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/constants/color_constants.dart';
import 'package:news_app/src/constants/string_constants.dart';
import 'package:news_app/src/core/blocs/top_headline_news/top_headlines_news_bloc.dart';
import 'package:news_app/src/core/blocs/top_headline_news/top_headlines_news_event.dart';
import 'package:news_app/src/core/blocs/top_headline_news/top_headlines_news_state.dart';
import 'package:news_app/src/di/app_initializer.dart';
import 'package:news_app/src/resource/dimensions/dimensions.dart';
import 'package:news_app/src/resource/theme/text_themes.dart';
import 'package:news_app/src/view/widgets/widget_failure_message.dart';
import 'package:news_app/src/view/widgets/widget_item_news.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final topHeadlinesNewsBloc = AppInitializer.getIt<TopHeadlinesNewsBloc>();
  final controllerKeyword = TextEditingController();
  final focusNodeIconSearch = FocusNode();
  late String? keyword;
  Timer? debounce;

  @override
  void initState() {
    keyword = '';
    controllerKeyword.addListener(_onSearching);
    super.initState();
  }

  @override
  void dispose() {
    focusNodeIconSearch.dispose();
    controllerKeyword.removeListener(_onSearching);
    controllerKeyword.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextThemes(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider<TopHeadlinesNewsBloc>(
        create: (context) => topHeadlinesNewsBloc,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: double.infinity,
              color: KColors.summerSky,
            ),
            SafeArea(
              child: Container(
                color: KColors.summerSky,
                width: size.width,
                padding: EdgeInsets.symmetric(vertical: Dimens.px8),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimens.px8, horizontal: Dimens.px16),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          const SizedBox(width: Dimens.px28),
                          Expanded(
                            child: Container(
                              height: Dimens.px50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(99.0),
                              ),
                              padding:
                                  EdgeInsets.symmetric(horizontal: Dimens.px16),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                        controller: controllerKeyword,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: KString.searching,
                                          hintStyle: TextThemes.h20
                                              ?.copyWith(color: KColors.grey),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        style: TextThemes.h20
                                            ?.copyWith(color: KColors.grey900)),
                                  ),
                                  Hero(
                                    tag: 'iconSearch',
                                    child: Focus(
                                      focusNode: focusNodeIconSearch,
                                      child: Icon(
                                        Icons.search,
                                        size: Dimens.px24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimens.px16),
                    Expanded(
                      child: BlocBuilder<TopHeadlinesNewsBloc,
                          TopHeadlinesNewsState>(
                        builder: (context, state) {
                          if (state is LoadingTopHeadlinesNewsState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is FailureTopHeadlinesNewsState) {
                            return WidgetFailureMessage();
                          } else if (state
                              is SearchSuccessTopHeadlinesNewsState) {
                            var listArticles = state.listArticles;
                            if (listArticles!.length == 0) {
                              return WidgetFailureMessage(
                                errorTitle: 'Data not found',
                                errorSubtitle:
                                    'Hm, we couldn\'t find what you were looking for.',
                              );
                            } else {
                              return ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimens.px8,
                                    vertical: Dimens.px8),
                                itemBuilder: (context, index) {
                                  var itemArticle = listArticles[index];
                                  var dateTimePublishedAt =
                                      DateFormat('yyy-MM-ddTHH:mm:ssZ').parse(
                                          itemArticle.publishedAt!, true);
                                  var strPublishedAt =
                                      DateFormat('MMM dd, yyyy HH:mm')
                                          .format(dateTimePublishedAt);
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: Dimens.px8),
                                    child: WidgetItemNews(
                                      itemArticle: itemArticle,
                                      strPublishedAt: strPublishedAt,
                                    ),
                                  );
                                },
                                itemCount: listArticles.length,
                              );
                            }
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSearching() {
    if (debounce?.isActive ?? false) {
      debounce?.cancel();
    }
    debounce = Timer(Duration(milliseconds: 800), () {
      var keyword = controllerKeyword.text.trim();
      if (keyword.isEmpty || this.keyword == keyword) {
        return;
      }
      this.keyword = keyword;
      focusNodeIconSearch.requestFocus();
      topHeadlinesNewsBloc.add(SearchTopHeadlinesNewsEvent(
          keyword: keyword, apiKey: KString.newsKey, country: KString.country));
    });
  }
}
