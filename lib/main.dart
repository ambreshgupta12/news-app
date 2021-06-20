import 'package:flutter/material.dart';
import 'package:news_app/src/constants/route_path.dart';
import 'package:news_app/src/di/app_initializer.dart';
import 'package:news_app/src/preferences/shared_prefernces.dart';
import 'package:news_app/src/resource/theme/app_theme.dart';
import 'package:news_app/src/routes/routes.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  AppInitializer.create();
  await Prefs.init(); // initialize here ! important
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
         initialRoute:RoutePath.HomeScreen
       ),
    );
  }
}




