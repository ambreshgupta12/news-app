import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/constants/asset_constants.dart';
import 'package:news_app/src/constants/color_constants.dart';
import 'package:news_app/src/data/models/top_headlines_news/articles.dart';
import 'package:news_app/src/resource/dimensions/dimensions.dart';
import 'package:news_app/src/resource/theme/text_themes.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetItemNews extends StatelessWidget {
  final Articles? itemArticle;
  final String? strPublishedAt;

  WidgetItemNews({
    @required this.itemArticle,
    @required this.strPublishedAt,
  });

  @override
  Widget build(BuildContext context) {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

    print('itemArticle:${itemArticle!.url}');
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(itemArticle!.url!)) {
          await launch(itemArticle!.url!);
        } else {
          scaffoldMessenger.showSnackBar(SnackBar(
            content: Text('Couldn\'t open detail news'),
          ));
        }
      },
      child: SizedBox(
        height: Dimens.px200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.px8),
              child: CachedNetworkImage(
                imageUrl: itemArticle!.urlToImage!=null?itemArticle!.urlToImage!:'https://static.toiimg.com/thumb/msid-83687407,width-1070,height-580,overlay-toi_sw,pt-32,y_pad-40,resizemode-75,imgsize-240433/83687407.jpg',
                fit: BoxFit.cover,
                width: Dimens.px200,
                height: Dimens.px200,
                errorWidget: (context, url, error) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.px8),
                    child: Image.asset(
                      AssetsConstant.imgNotFound,
                      fit: BoxFit.cover,
                      width: Dimens.px200,
                      height: Dimens.px200,
                    ),
                  );
                },
                placeholder: (context, url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.px8),
                    child: Image.asset(
                      AssetsConstant.imgPlaceholder,
                      fit: BoxFit.cover,
                      width: Dimens.px200,
                      height: Dimens.px200,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: Dimens.px16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    itemArticle!.title!,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                      style: TextThemes.h20?.copyWith()
                  ),
                  itemArticle!.author == null
                      ? Container()
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              itemArticle!.author!,
                          overflow: TextOverflow.ellipsis,
                           style: TextThemes.h16?.copyWith(color: KColors.grey)

                  ),
                          Text(
                              strPublishedAt!,
                              overflow: TextOverflow.ellipsis,
                              style: TextThemes.h16?.copyWith(color: KColors.grey)

                          )
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
}
