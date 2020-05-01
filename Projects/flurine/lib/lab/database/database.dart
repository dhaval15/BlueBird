import 'package:flurine/lab/actions/action.dart';
import 'package:flurine/lab/canvas/scene.dart';
import 'package:flurine_lambda/flurine_lambda.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

abstract class Database {
  static Database instance = HiveDatabase();

  static convertToJson(List<Flux> list) => list..map((e) => e.toJson()).toList();

  Lambda queryLambda(String key);

  Action queryAction(String key);

  Scene queryScene(String key);

  addGlobalLambda(Lambda lambda){
    _pushKey(lambda);
  }

  addGlobalScene(Scene scene){
    _pushKey(scene);
  }

  addGlobalAction(Action action){
    _pushKey(action);
  }

  editGlobalLambda(Lambda lambda);

  editGlobalScene(Scene flexine);

  editGlobalAction(Action action);

  _pushKey(dynamic flux) {
    flux.key = _generateKey();
  }

  String _generateKey();

  export();
}

class HiveDatabase extends Database {
  final Box _actionBox = Hive.box('actions'),
      _flexineBox = Hive.box('flexines'),
      _lambdaBox = Hive.box('lambdas');

  @override
  addGlobalAction(Action action) {
    super.addGlobalAction(action);
    _actionBox.put(action.key, action.toJson());
  }

  @override
  addGlobalScene(Scene flexine) {
    super.addGlobalScene(flexine);
    _flexineBox.put(flexine.key, flexine.toJson());
  }

  @override
  addGlobalLambda(Lambda lambda) {
    super.addGlobalLambda(lambda);
    _lambdaBox.put(lambda.key, lambda.toJson());
  }

  @override
  String _generateKey() => Uuid().v1();

  @override
  Action queryAction(String key) => Action.fromKey(_actionBox.get(key));

  @override
  Scene queryScene(String key) => Scene.fromJson(_flexineBox.get(key));

  @override
  Lambda queryLambda(String key) => Lambda.fromJson(_lambdaBox.get(key));

  @override
  editGlobalAction(Action action) {
    _actionBox.put(action.key, action.toJson());
  }

  @override
  editGlobalScene(Scene scene) {
    _flexineBox.put(scene.key, scene.toJson());
  }

  @override
  editGlobalLambda(Lambda lambda) {
    _lambdaBox.put(lambda.key, lambda.toJson());
  }

  @override
  export() {

  }
}

mixin Flux {
  String key;

  dynamic toJson();
}
