import '../../entities/system_app.dart';

abstract class AppRegistry {
  List<SystemApp> get apps;
  SystemApp? getApp(String id);
}
