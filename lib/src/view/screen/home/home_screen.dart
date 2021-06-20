import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/constants/asset_constants.dart';
import 'package:news_app/src/constants/color_constants.dart';
import 'package:news_app/src/constants/decoration_constants.dart';
import 'package:news_app/src/constants/route_path.dart';
import 'package:news_app/src/constants/string_constants.dart';
import 'package:news_app/src/core/blocs/top_headline_news/top_headlines_news_bloc.dart';
import 'package:news_app/src/core/blocs/top_headline_news/top_headlines_news_event.dart';
import 'package:news_app/src/core/blocs/top_headline_news/top_headlines_news_state.dart';
import 'package:news_app/src/data/models/category_news/category_news.dart';
import 'package:news_app/src/data/models/top_headlines_news/articles.dart';
import 'package:news_app/src/di/app_initializer.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/resource/dimensions/dimensions.dart';
import 'package:news_app/src/resource/theme/text_themes.dart';
import 'package:news_app/src/view/screen/home/category_news_widget.dart';
import 'package:news_app/src/view/widgets/widget_failure_message.dart';
import 'package:news_app/src/view/widgets/widget_item_news.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CategoryNews> categoriesList = [];
  final topHeadlinesNewsBloc = AppInitializer.getIt<TopHeadlinesNewsBloc>();
  var indexCategorySelected = 0;
  final refreshIndicatorState = GlobalKey<RefreshIndicatorState>();
  Completer? completerRefresh;

  @override
  void initState() {
    initCategoryNewsData();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      topHeadlinesNewsBloc.add(LoadTopHeadlinesNewsEvent(
          category: '',
          apiKey: KString.newsKey,
          country: KString.country,
          pageSize: 100));
      completerRefresh = Completer();
      refreshIndicatorState.currentState!.show();
    });
    super.initState();
  }

  void initCategoryNewsData() {
    categoriesList.add(CategoryNews(image: '', title: KString.all));
    categoriesList.add(CategoryNews(
        image: AssetsConstant.imgBusiness, title: KString.business));
    categoriesList.add(CategoryNews(
        image: AssetsConstant.imgEntertainment, title: KString.entertainment));
    categoriesList.add(
        CategoryNews(image: AssetsConstant.imgHealth, title: KString.health));
    categoriesList.add(
        CategoryNews(image: AssetsConstant.imgScience, title: KString.science));
    categoriesList.add(
        CategoryNews(image: AssetsConstant.imgSport, title: KString.sports));
    categoriesList.add(CategoryNews(
        image: AssetsConstant.imgTechnology, title: KString.technology));
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

    final size = MediaQuery.of(context).size;
    TextThemes(context);
    return Scaffold(
      body: BlocProvider<TopHeadlinesNewsBloc>(
          create: (context) => topHeadlinesNewsBloc,
          child: BlocListener<TopHeadlinesNewsBloc, TopHeadlinesNewsState>(
            listener: (context, state) {
              if (state is FailureTopHeadlinesNewsState) {
                _resetRefreshIndicator();
              } else if (state is LoadedTopHeadlinesNewsState) {
                _resetRefreshIndicator();
              } else if (state is ChangeCategoryTopHeadlinesNewsState) {
                indexCategorySelected = state.indexCategorySelected!;
                var category = categoriesList[indexCategorySelected]
                            .title!
                            .toLowerCase() ==
                        'all'
                    ? categoriesList[indexCategorySelected].title!.toLowerCase()
                    : '';
                topHeadlinesNewsBloc.add(LoadTopHeadlinesNewsEvent(
                    category: category,
                    apiKey: KString.newsKey,
                    country: KString.country,
                    pageSize: 100));
                refreshIndicatorState.currentState!.show();
              }
            },
            child: Stack(
              children: [
                SafeArea(
                  child: Container(
                    width: size.width,
                    color: KColors.summerSky,
                    padding: EdgeInsets.symmetric(vertical: Dimens.px8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Dimens.px8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: ListTile(
                                  title: Text(KString.dailyNews,
                                      style: TextThemes.h24?.copyWith(
                                          fontWeight: FontWeight.w600)),
                                  subtitle: Text(
                                      DateFormat('EEEE, MMM dd, yyyy')
                                          .format(DateTime.now()),
                                      style: TextThemes.h20
                                          ?.copyWith(color: Colors.grey)),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, RoutePath.SearchScreen),
                                child: const Hero(
                                  tag: 'iconSearch',
                                  child: Icon(
                                    Icons.search,
                                    size: Dimens.px24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimens.px8),
                        CategoryNewsWidget(
                            listCategories: categoriesList,
                            indexDefaultSelected: indexCategorySelected),
                        const SizedBox(height: Dimens.px8),
                        Expanded(
                          child: _buildWidgetContentNews(
                              size: size, scaffoldMessenger: scaffoldMessenger),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _resetRefreshIndicator() {
    completerRefresh?.complete();
    completerRefresh = Completer();
  }

  Widget _buildWidgetContentNews(
      {@required Size? size,
      @required ScaffoldMessengerState? scaffoldMessenger}) {
    return BlocBuilder<TopHeadlinesNewsBloc, TopHeadlinesNewsState>(
      builder: (context, state) {
        List<Articles> articlesList = <Articles>[];
        if (state is LoadedTopHeadlinesNewsState) {
          articlesList.addAll(state.articles!);
        }
        return Stack(
          children: <Widget>[
            RefreshIndicator(
              key: refreshIndicatorState,
              onRefresh: () {
                topHeadlinesNewsBloc.add(
                  LoadTopHeadlinesNewsEvent(
                      category: categoriesList[indexCategorySelected]
                                  .title!
                                  .toLowerCase() ==
                              'all'
                          ? ''
                          : categoriesList[indexCategorySelected]
                              .title!
                              .toLowerCase(),
                      apiKey: KString.newsKey,
                      country: KString.country),
                );
                return completerRefresh!.future;
              },
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimens.px8, vertical: Dimens.px8),
                itemBuilder: (context, index) {
                  Articles? itemArticle = articlesList[index];
                  var dateTimePublishedAt = DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                      .parse(itemArticle.publishedAt!, true);
                  var strPublishedAt = DateFormat('MMM dd, yyyy HH:mm')
                      .format(dateTimePublishedAt);
                  if (index == 0) {
                    return _buildWidgetItemLatestNews(
                        size: size,
                        strPublishedAt: strPublishedAt,
                        itemArticle: itemArticle,
                        scaffoldMessenger: scaffoldMessenger);
                  } else {
                    return _buildWidgetItemNews(
                        index, itemArticle, strPublishedAt);
                  }
                },
                itemCount: articlesList.length,
              ),
            ),
            articlesList.isEmpty && state is FailureTopHeadlinesNewsState
                ? _buildWidgetFailureLoadData()
                : Container(),
          ],
        );
      },
    );
  }

  Widget _buildWidgetItemNews(
    int index,
    Articles itemArticle,
    String strPublishedAt,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        top: index == 1 ? Dimens.px24 : Dimens.px16,
        bottom: Dimens.px16,
      ),
      child: WidgetItemNews(
        itemArticle: itemArticle,
        strPublishedAt: strPublishedAt,
      ),
    );
  }

  Widget _buildWidgetItemLatestNews(
      {@required Articles? itemArticle,
      @required String? strPublishedAt,
      @required Size? size,
      @required ScaffoldMessengerState? scaffoldMessenger}) {
    return GestureDetector(
      onTap: () async {
        print('itemArticle!.url!:${itemArticle!.url!}');
        if (await canLaunch(itemArticle.url!)) {
          await launch(
            itemArticle.url!,
            forceSafariVC: true,
            forceWebView: true,
          );
        } else {
          scaffoldMessenger!.showSnackBar(SnackBar(
            content: Text('Couldn\'t open detail news'),
          ));
        }
      },
      child: Container(
        height: size!.height / 1.7,
        width: size.width,
        decoration: KDecoration.boxDecoration(radius: Dimens.px8).copyWith(
            image: DecorationImage(
          image: NetworkImage(
            itemArticle!.urlToImage!,
          ),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: <Widget>[
            Container(
              width: size.width,
              height: size.height / 1.7,
              decoration:
                  KDecoration.boxDecoration(radius: Dimens.px8).copyWith(
                      gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(0.0),
                ],
                stops: [
                  0.0,
                  1.0,
                ],
              )),
              padding: EdgeInsets.all(Dimens.px16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: KDecoration.boxDecoration(
                        radius: Dimens.px46, color: KColors.pink),
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.px28,
                      vertical: Dimens.px14,
                    ),
                    child: Text(KString.latestNews,
                        style: TextThemes.h20?.copyWith(
                          color: KColors.white,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  const SizedBox(height: Dimens.px16),
                  Text(itemArticle.title!,
                      style: TextThemes.h24?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(height: Dimens.px8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(strPublishedAt!,
                          overflow: TextOverflow.ellipsis,
                          style: TextThemes.h18?.copyWith(color: Colors.grey)),
                      Text(' | ',
                          style: TextThemes.h20?.copyWith(color: Colors.grey)),
                      Text(itemArticle.source!.name!,
                          overflow: TextOverflow.ellipsis,
                          style: TextThemes.h18?.copyWith(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetFailureLoadData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WidgetFailureMessage(),
          TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(KColors.grey800),
            ),
            onPressed: () {
              refreshIndicatorState.currentState!.show();
            },
            child: Text('Try Again'.toUpperCase(),
                style: TextThemes.h24?.copyWith(color: Colors.white)),
          )
        ],
      ),
    );
  }
}

class WidgetDateToday extends StatefulWidget {
  @override
  _WidgetDateTodayState createState() => _WidgetDateTodayState();
}

class _WidgetDateTodayState extends State<WidgetDateToday> {
  String? strToday;

  @override
  void initState() {
    strToday = DateFormat('EEEE, MMM dd, yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Text(
        strToday!,
        style: TextStyle(
          fontSize: 28,
          color: Colors.grey,
        ),
      ),
    );
  }
}
