part of 'api.dart';

class Cookbook {
  final int id;
  final String name;

  Cookbook(this.id, this.name);

  static Cookbook _fromJson(Map content) =>
      Cookbook(content['id'], content['name']);
}
