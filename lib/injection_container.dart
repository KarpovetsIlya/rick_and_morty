import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/api/dio_configurator.dart';
import 'package:rick_and_morty/api/service/rick_and_morty_api.dart';
import 'package:rick_and_morty/api/service/rick_and_morty_api_intarface.dart';

final getIt = GetIt.instance;

Future<void> initInjectionContainer() async {
  final dio = const DioConfigurator().create();
  getIt.registerSingleton<Dio>(dio);

  getIt.registerLazySingleton<InternetService>(
      () => InternetServiceDio(getIt<Dio>()));
}
