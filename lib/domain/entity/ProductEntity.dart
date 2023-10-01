import 'package:equatable/equatable.dart';

class ProductEntity {
  int id;
  String name;
  String? slug;
  String description;
  double marketPrice;
  double sellingPrice;
  String? thumbnail;
  int? stock;
  bool preOrder;
  String? dateAdded;
  String? createDate;
  String? updatedDate;
  int? region;
  int? business;
  int? category;
  int? tax;
  List<QuantityVariant> quantityType;
  int? colorType;
  int? sizeType;
  int? createdUser;
  int? updatedUser;
  List<ImageEntity>? images;
  bool? isFavourite;

  ProductEntity(
      {required this.id,
      required this.name,
      this.slug,
      required this.description,
      required this.marketPrice,
      required this.sellingPrice,
      required this.thumbnail,
      this.stock,
      required this.preOrder,
      this.dateAdded,
      this.createDate,
      this.updatedDate,
      this.region,
      this.business,
      this.category,
      this.tax,
      required this.quantityType,
      this.colorType,
      this.sizeType,
      this.createdUser,
      this.updatedUser,
      this.images,
      required this.isFavourite});
}

class ImageEntity {
  ImageEntity({
    required this.id,
    this.isVedio,
    this.image,
    required this.createdDate,
    required this.uploadedUser,
  });

  int id;
  String? isVedio;
  String? image;
  DateTime createdDate;
  int uploadedUser;

  factory ImageEntity.fromJson(Map<String, dynamic> json) => ImageEntity(
        id: json["id"],
        isVedio: json["is_vedio"],
        image: json["image"],
        createdDate: DateTime.parse(json["created_date"]),
        uploadedUser: json["uploaded_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_vedio": isVedio,
        "image": image,
        "created_date": createdDate.toIso8601String(),
        "uploaded_user": uploadedUser,
      };
}
/*
class QuantityVariant1 extends Equatable {
  final int id;
  final String variantName;
  final double price;
  final double sellingPrice;

  QuantityVariant(
      {required this.id,
      required this.variantName,
      required this.price,
      required this.sellingPrice});

  factory QuantityVariant.fromJson(Map<String, dynamic> json) =>
      QuantityVariant(
          id: json['id'],
          variantName: json['variant_name'],
          price: json['price'],
          sellingPrice: json['selling_price']);

  @override
  List<Object?> get props => [id, variantName, price];
}*/

class QuantityVariant extends Equatable {
  int? id;
  String? variantName;
  dynamic variantImage;
  final SizeVariant sizeVariant;

  QuantityVariant(
      {this.id,
      this.variantName,
      this.variantImage,
      required this.sizeVariant});

  factory QuantityVariant.fromJson(Map<String, dynamic> json) =>
      QuantityVariant(
        id: json["id"],
        variantName: json["variant_name"],
        variantImage: json["variant_image"],
        sizeVariant: SizeVariant.fromJson(json["size_variant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "variant_name": variantName,
        "variant_image": variantImage,
        "size_variant": sizeVariant.toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class SizeVariant {
  int? id;
  String? sizeName;
  double? price;

  SizeVariant({this.id, this.sizeName, this.price});

  SizeVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sizeName = json['size_name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size_name'] = this.sizeName;
    data['price'] = this.price;
    return data;
  }
}
