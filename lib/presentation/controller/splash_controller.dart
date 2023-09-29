import 'package:get/get.dart';
import 'package:grocery_app/domain/usecase/get_token_usercase.dart';
import 'package:grocery_app/presentation/routes.dart';

class SplashController extends GetxController {
  final GetTokenUserCase getTokenUserCase;

  SplashController(this.getTokenUserCase);

  checkToken() async {
    Get.offAndToNamed(AppRoutes.homescreen);
    // try {
    //   var token = await getTokenUserCase.call(NoParams());
    //   if (token == "") {
    //     Get.offAndToNamed(AppRoutes.register);
    //   } else {
    //     Get.offAndToNamed(AppRoutes.dashBoard);
    //   }
    // } catch (e) {
    //   Get.offAndToNamed(AppRoutes.register);
    // }
  }
}
