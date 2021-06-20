import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/src/constants/route_path.dart';
import 'package:news_app/src/view/screen/home/home_screen.dart';
import 'package:news_app/src/view/screen/search/search_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case RoutePath.HomeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RoutePath.SearchScreen:
        return MaterialPageRoute(builder: (_) => SearchScreen());

      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
