import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery_app/core/custom_exception.dart';
import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/domain/entity/quantity_cart_model.dart';
import 'package:grocery_app/domain/usecase/add_cart_use_case.dart';
import 'package:grocery_app/domain/usecase/get_cart_use_case.dart';
import 'package:grocery_app/presentation/routes.dart';

import '../../core/response_classify.dart';
import '../../domain/entity/cart_entity.dart';
import '../../domain/usecase/delete_cart_use_case.dart';
import '../helpers/enums.dart';

class CartController extends GetxController {
  final AddCartUseCase addCartUseCase;
  final GetCartUseCase getCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;

  CartController(
      this.addCartUseCase, this.getCartUseCase, this.deleteCartUseCase) {}
  final cartList = Rxn<CartEntity>();

  final getCartResponse = ResponseClassify<CartEntity>.loading().obs;
  final addCartResponse = ResponseClassify<CartData>.error("").obs;
  final deleteCartResponse = ResponseClassify<NoParams>.loading().obs;
  final noteController = TextEditingController();
  final cartListTemp = <CartProduct>[].obs;
  QuantityCartModel? checkCartContains(
      {required QuantityVariant variant, required ProductEntity product}) {
    print("cartLst" + cartListTemp.length.toString());
    var found = cartListTemp
        .firstWhereOrNull((element) => element.product.id == product.id);
    if (found != null) {
      print("found ${found.qtyType.first.variant.id} ${variant.id}");
      return found.qtyType
          .firstWhereOrNull((element) => element.variant.id == variant.id);
    }
    return null;
  }

  getCart() async {
    getCartResponse.value = ResponseClassify.loading();
    try {
      getCartResponse.value = ResponseClassify<CartEntity>.completed(
          await getCartUseCase.call(NoParams()));
      // cartList.addAll(getCartResponse.value.data.data.products);
      cartList.value = getCartResponse.value.data;
      cartListTemp.clear();
      cartListTemp.addAll(cartList.value?.data.products ?? []);
      debugPrint(
          "response length ${getCartResponse.value.data?.data.products.length}");
    } on UnauthorisedException {
      var storage = GetStorage();
      storage.remove('token');
      storage.remove('user');
      Get.toNamed(AppRoutes.register);
      // getCartResponse.value = ResponseClassify.error(e.toString());
    } catch (e) {
      getCartResponse.value = ResponseClassify.error(e.toString());
    }
  }

  updateCartProduct({
    required CartProduct product,
    required bool increment,
    required QuantityVariant qty,
  }) {
    debugPrint("--UPDATING PRODUCT--");
    if (cartList.value!.data.products.contains(product)) {
      CartProduct data = cartList.value!.data.products
          .firstWhere((element) => element.id == product.id);
      if (increment) {
        data.quantity = data.quantity + 1;
        var q = data.qtyType
            .firstWhereOrNull((element) => element.variant.id == qty.id);
        if (q != null) {
          q.qty = q.qty + 1;
        }
        // addCart(data, data.quantity, data.)
      } else {
        data.quantity = data.quantity - 1;
        var q = data.qtyType
            .firstWhereOrNull((element) => element.variant.id == qty.id);
        if (q != null) {
          q.qty = q.qty - 1;
        }
        if (data.quantity <= 0) {
          deleteCart(data.id!);
        }
      }
      cartList.refresh();
      updateCart();
    }
  }

  updateCartProductDetail({
    required ProductEntity product,
    required bool increment,
    required QuantityVariant qty,
  }) {
    debugPrint("--UPDATING PRODUCT--");
    var haveOnCart = cartList.value?.data.products
        .firstWhereOrNull((element) => element.product.id == product.id);
    if (haveOnCart != null) {
      CartProduct data = cartList.value!.data.products
          .firstWhere((element) => element.product.id == product.id);
      if (increment) {
        data.quantity = data.quantity + 1;
        var q = data.qtyType
            .firstWhereOrNull((element) => element.variant.id == qty.id);
        if (q != null) {
          q.qty = q.qty + 1;
        }
        // addCart(data, data.quantity, data.)
      } else {
        data.quantity = data.quantity - 1;
        var q = data.qtyType
            .firstWhereOrNull((element) => element.variant.id == qty.id);
        if (q != null) {
          q.qty = q.qty - 1;
        }
        if (data.quantity <= 0) {
          deleteCart(data.id!);
        }
      }
      cartList.refresh();
      updateCart();
    }
  }

  addCart(ProductEntity product, QuantityVariant qty, int quantity) async {
    debugPrint("--CART PRODUCT ADDING--");
    addCartResponse.value = ResponseClassify.loading();
    try {
      addCartResponse.value = ResponseClassify<CartData>.completed(
          await addCartUseCase.call(CartData(
        products: [
          CartProduct(
              qtyType: [QuantityCartModel(qty: quantity, variant: qty)],
              product: product,
              quantity: quantity,
              subtotal: 0.0,
              productStatus: ProductStatus.PENDING,
              price: 0.0)
        ],
        total: 0.0,
      )));
      cartListTemp.clear();
      cartListTemp.addAll(addCartResponse.value.data?.products ?? []);
      Get.snackbar(
          "Item Added To Cart", "${product.name} added to cart successfully",
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.GROUNDED,
          backgroundColor: Colors.black87,
          colorText: Colors.white);
    } on UnauthorisedException {
      var storage = GetStorage();
      storage.remove('token');
      storage.remove('user');
      Get.toNamed(AppRoutes.register);
      // getCartResponse.value = ResponseClassify.error(e.toString());
    } catch (e) {
      debugPrint(e.toString());
      addCartResponse.value = ResponseClassify.error(e.toString());
    }
  }

  updateCart() async {
    debugPrint("--CART PRODUCT UPDATING--");
    addCartResponse.value = ResponseClassify.loading();
    try {
      addCartResponse.value = ResponseClassify<CartData>.completed(
          await addCartUseCase.call(cartList.value!.data));
      cartListTemp.clear();
      cartListTemp.addAll(addCartResponse.value.data?.products ?? []);
      // getCart();
    } catch (e) {
      debugPrint(e.toString());
      addCartResponse.value = ResponseClassify.error(e.toString());
    }
  }

  deleteCart(int id) async {
    debugPrint("--CART PRODUCT DELETING--");
    deleteCartResponse.value = ResponseClassify.loading();
    try {
      cartList.value!.data.products.removeWhere((element) => element.id == id);

      deleteCartResponse.value = ResponseClassify<NoParams>.completed(
          await deleteCartUseCase.call(id));
    } catch (e) {
      debugPrint(e.toString());
      deleteCartResponse.value = ResponseClassify.error(e.toString());
    }
    update();
  }

  final selectedPaymentType = "COD".obs;
  changeSelectedPaymentType(String item) {
    selectedPaymentType.value = item;
  }
}
