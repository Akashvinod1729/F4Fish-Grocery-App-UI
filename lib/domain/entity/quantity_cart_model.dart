import 'package:grocery_app/domain/entity/ProductEntity.dart';

class QuantityCartModel{
  final int qty;
  final QuantityVariant variant;

  QuantityCartModel({required this.qty, required this.variant});

  toJson()=>{
     "quantity":qty,
    "varient":variant
   };
}