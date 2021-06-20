import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/constants/color_constants.dart';
import 'package:news_app/src/constants/decoration_constants.dart';
import 'package:news_app/src/constants/string_constants.dart';
import 'package:news_app/src/core/blocs/top_headline_news/top_headlines_news_bloc.dart';
import 'package:news_app/src/core/blocs/top_headline_news/top_headlines_news_event.dart';
import 'package:news_app/src/data/models/category_news/category_news.dart';
import 'package:news_app/src/resource/dimensions/dimensions.dart';
import 'package:news_app/src/resource/theme/text_themes.dart';

class CategoryNewsWidget extends StatefulWidget {
  final List<CategoryNews>? listCategories;
  final int? indexDefaultSelected;

  CategoryNewsWidget({
    @required this.listCategories,
    @required this.indexDefaultSelected,
  });

  @override
  _WidgetCategoryNewsWidgetState createState() => _WidgetCategoryNewsWidgetState();
}

class _WidgetCategoryNewsWidgetState extends State<CategoryNewsWidget> {
  int? indexCategorySelected;

  @override
  void initState() {
    indexCategorySelected = widget.indexDefaultSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.px90,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: Dimens.px16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var itemCategory = widget.listCategories![index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? Dimens.px0 : Dimens.px8,
              right: index == widget.listCategories!.length - 1 ? Dimens.px0 : Dimens.px8,
            ),
            child: GestureDetector(
              onTap: () {
                if (indexCategorySelected == index) {
                  return;
                }
                setState(() => indexCategorySelected = index);
                var topHeadlinesNewsBloc = BlocProvider.of<TopHeadlinesNewsBloc>(context);
                topHeadlinesNewsBloc.add(
                  ChangeCategoryTopHeadlinesNewsEvent(indexCategorySelected: index),
                );
              },
              child: Container(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: itemCategory.title!.toLowerCase() == KString.all.toLowerCase() ? Dimens.px48 : Dimens.px32,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(indexCategorySelected == index ? 0.2 : 0.6),
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimens.px4),
                      ),
                      border: indexCategorySelected == index
                          ? Border.all(
                        color: Colors.white,
                        width: Dimens.px2,
                      )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        itemCategory.title!,
                        style: TextThemes.h24?.copyWith(
                            color: KColors.white
                        ),
                      ),
                    ),
                  ),
                  decoration: KDecoration.boxDecoration(radius: Dimens.px4,color: itemCategory.title!.toLowerCase() == 'all' ? KColors.pigeonPostColor : null).copyWith(
                    image: itemCategory.title!.toLowerCase() == KString.all.toLowerCase() ? null : DecorationImage(
                      image: AssetImage(
                        itemCategory.image!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  )
              ),
            ),
          );
        },
        itemCount: widget.listCategories!.length,
      ),
    );
  }
}