import 'package:get/get.dart';
import 'package:grocery_app/presentation/routes.dart';

class AccountItem {
  final String label;
  final String iconPath;
  final Function onTap;

  AccountItem(
      {required this.label, required this.iconPath, required this.onTap});
}

List<AccountItem> accountItems = [
  AccountItem(
      label: "Orders",
      iconPath: "assets/icons/account_icons/orders_icon.svg",
      onTap: () => Get.toNamed(AppRoutes.orders)),
  AccountItem(
      label: "Delivery Addresses",
      iconPath: "assets/icons/account_icons/delivery_icon.svg",
      onTap: () => {Get.toNamed(AppRoutes.address)}),
   AccountItem(
       label: "Notifications",
       iconPath: "assets/icons/account_icons/notification_icon.svg",
       onTap: () => {}),
   AccountItem(
       label: "Help",
       iconPath: "assets/icons/account_icons/help_icon.svg",
       onTap: () => {}),
  AccountItem(
      label: "About Us",
      iconPath: "assets/icons/account_icons/about_icon.svg",
      onTap: () => {}),
];
