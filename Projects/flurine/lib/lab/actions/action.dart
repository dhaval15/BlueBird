import 'package:flurine/lab/database/database.dart';

class Action with Flux {
  factory Action.fromKey(String key) => Database.instance.queryAction(key);

  @override
  Map<String, dynamic> toJson() => {};
}
