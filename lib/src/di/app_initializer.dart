import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/src/core/blocs/top_headline_news/top_headlines_news_bloc.dart';
import 'package:news_app/src/core/network/network_info.dart';
import 'package:news_app/src/data/repositories/news_app_repository.dart';


class AppInitializer {
  AppInitializer._();

  static GetIt getIt = GetIt.I;

  static initGetIt() {
    getIt = GetIt.I;
    create();
  }


  static void create() {
    _initRepos();
    _initNotifiers();
    _initBlocs();
  }

  static void _initRepos() {
    getIt.registerLazySingleton(() => NewsAppRepository());
  }

/*
* !Core
* */
  static void _initNotifiers() {
    getIt.registerLazySingleton(() => DataConnectionChecker());
    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  }

  /*
* !Bloc
* */
  static void _initBlocs() {

    getIt.registerFactory(() => TopHeadlinesNewsBloc());
    /*getIt.registerLazySingleton(() => SplashScreenCubit());
    getIt.registerLazySingleton(() => AdvisorloginPhoneBloc());
    getIt.registerFactory(() => AdvisorloginotpBloc());
    getIt.registerLazySingleton(() => AdvisorperosnalinfoCubit());
    getIt.registerLazySingleton(() => AdvisoraddressCubit());
    getIt.registerLazySingleton(() => NavigationService());
    getIt.registerLazySingleton(() => AppLocalizations());
    getIt.registerLazySingleton(() => DynamicLinkService());
    getIt.registerLazySingleton(() => AdvisorleadsbayCubit());*/



  }

  static void close() {
    getIt.reset();
  }
}
