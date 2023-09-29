import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app_constants.dart';
import 'package:grocery_app/core/response_classify.dart';
import 'package:grocery_app/presentation/routes.dart';
import 'package:pelaicons/pelaicons.dart';
import '../../../common_widgets/app_text.dart';
import '../../controller/auth_controller.dart';
import '../../helpers/column_with_seprator.dart';
import '../../styles/colors.dart';
import 'account_item.dart';


class AccountScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authController.getUserData();
    });


    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          spacer30,
            SizedBox(
              height: 100,
              child: Obx(() => authController.getUserDataResponse.value.status ==
                      Status.LOADING
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20,),
                  Container(
                    height: 60,
                    width: 60,
                    decoration:BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  SizedBox(width:20,),

                  Container(
                    height: 60,
                    width: 200,
                    decoration:BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))
                    )
                  )
                ],
              )
                  : Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))
              ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          spacerW15,
                          SizedBox(
                              width: 45, height: 45, child: getImageHeader()),
                          spacerW10,
                          AppText(
                            text: authController
                                .getUserDataResponse.value.data?.mobile ??
                                "",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            spacer20,
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  spacerW30,
                  Container(
                      width: 70,
                      height: 70,
                      decoration:BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    child: Center(
                      child: IconButton(
                        onPressed: () =>
                            Get.toNamed(AppRoutes.cart),
                        icon: Icon(Pelaicons.heart_light_outline,
                          size: 27,
                          color: Colors.black,),
                      ),
                    ),
                  ),
                  spacerW30,

                  Container(
                    width: 70,
                    height: 70,
                    decoration:BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                   child: Center(
                      child: IconButton(
                        onPressed: () =>
                            Get.toNamed(AppRoutes.cart),
                        icon: Icon(Pelaicons.settings_light_outline,
                          size: 27,
                          color: Colors.black,),
                      ),
                    ),
                  ),
                  spacerW30,

                  Container(
                    width: 70,
                    height: 70,
                    decoration:BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () =>
                            Get.toNamed(AppRoutes.cart),
                        icon: Icon(Pelaicons.cart_2_light_outline,
                          size: 27,
                          color: Colors.black,),
                      ),
                    ),
                  ),
                  spacerW30,
                ],
              ),
            ),
            spacer20,
            ///Account items like orders,noti,help...
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              padding: EdgeInsets.only(top: 0),
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  spacer10,
                  SizedBox(
                    child: Column(
                      children: getChildrenWithSeperator(
                        widgets: accountItems.map((e) {
                          return getAccountItemWidget(e);
                        }).toList(),
                        seperator: Divider(
                          thickness: 1,
                        ),
                      ),
                    ),
                  ),
                  spacer10,
                ],
              ),
            ),
            spacer10,///logout button
            GestureDetector(
              onTap: () {
                authController.logOut();
                Get.offNamed(AppRoutes.register);
              },
              child: Container(
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: SvgPicture.asset(
                        "assets/icons/account_icons/logout_icon.svg",
                      ),
                    ),
                    spacerW30,
                    Text(
                      "Log Out",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget logoutButton() {
    return GestureDetector(
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),      padding: EdgeInsets.symmetric(horizontal: 25),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: SvgPicture.asset(
                  "assets/icons/account_icons/logout_icon.svg",
                ),
              ),
              Text(
                "Log Out",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
              Container()
            ],
          ),

        ),
    );
  }



  Widget getImageHeader() {
    String imagePath = "assets/images/account_image.png";
    return CircleAvatar(
      radius: 5.0,
      backgroundImage: AssetImage(
        imagePath,
      ),
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    );
  }

  Widget getAccountItemWidget(AccountItem accountItem) {
    return InkWell(
      onTap: () => accountItem.onTap(),
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: SvgPicture.asset(
                accountItem.iconPath,color: Colors.black54,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              accountItem.label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios,size: 15,color: Colors.black54,)
          ],
        ),
      ),
    );
  }
}
