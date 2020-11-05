import 'package:flutter/foundation.dart';

enum Category { all, green, ethical, }

class Product {
  const Product({
    @required this.category,
    @required this.id,
    @required this.name,
    @required this.rate,
  })  : assert(category != null),
        assert(id != null),
        assert(name != null),
        assert(rate != null);

  final Category category;
  final int id;
  final String name;
  final int rate;

  String get assetName {
    Category cat = this.category;
    return cat == Category.green ? 'assets/green.png' : 'assets/blue.png';
  }

  @override
  String toString() => "Taux : $rate%";

}