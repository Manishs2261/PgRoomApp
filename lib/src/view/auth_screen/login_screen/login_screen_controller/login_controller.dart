import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/uitels/helpers/heiper_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../repositiry/apis/apis.dart';
import '../../../../repositiry/auth_apis/auth_apis.dart';
import '../../../../res/route_name/routes_name.dart';
import '../../../splash/controller/splash_controller.dart';

class LoginScreenController extends GetxController {
  final emailControlerLogin = TextEditingController().obs;
  final passwordControlerLogin = TextEditingController().obs;
  Connectivity connectivity = Connectivity();

  RxBool worngpassword = false.obs;
  RxBool passView = true.obs;
  RxBool loading = false.obs;

  onLoginButton(BuildContext context) async {
    await connectivity.checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        AppHelperFunction.showSnackBar("Please Check Your Internet Connection");
      } else {
        loading.value = true;
        AuthApisClass.loginEmailAndPassword(emailControlerLogin.value.text, passwordControlerLogin.value.text)
            .then((value) async {
          //if user use wrong password and email id thna
          // not to allow next page navigation
          worngpassword.value = value;

          loading.value = false;
          if (worngpassword.value) {
            // Login sharedPrefrence code +++++++++
            SharedPreferences prefrence = await SharedPreferences.getInstance();
            // store a data in sharedPrefrence
            prefrence.setString('userUid', ApisClass.user.uid);
            //initialize  a varible
            finalUserUidGloble = prefrence.getString('userUid');
            //========================
            Get.offAllNamed(RoutesName.homeScreen);
          }
        });
      }
    });
  }
}
