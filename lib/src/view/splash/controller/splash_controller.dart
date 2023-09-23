import 'package:get/get.dart';
import 'package:pgroom/src/view/home/home_screen.dart';

class SplashController extends GetxController{

  static SplashController get find => Get.find();

  Future<void> startSplashScreen() async {

    await Future.delayed(Duration(milliseconds: 5000));
    Get.to(()=> HomeScreen());


  }


}