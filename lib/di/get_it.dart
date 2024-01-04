import 'package:auto_silent_app/di/get_it.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true,
)
Future<void> configureDependencies() async => await getIt.init();
