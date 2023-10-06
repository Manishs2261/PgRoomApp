import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:pgroom/main.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/auth_screen/forget_password_phone_number/forget_password_phone_number.dart';
import 'package:pgroom/src/view/home/home_screen.dart';

import '../forget_password_email/forget_password.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final globleKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        //=======skip buttton ========
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
              },
                child: Text("Skip",style: TextStyle(fontSize: 18),)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(

  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(loginImage,),width: 150,height: 150,fit:
            BoxFit.cover,),
            Text("Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight
                .w400,letterSpacing: 1),),
            Text("Welcome Back ",style: TextStyle(fontSize: 16,letterSpacing:
            1,),),

            SizedBox(height: 50,),
              Form(
                key: globleKey,
                  child: Column(
                children: [

                  //===========Email and phone number  text
                  // field===============
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Email id or Number",
                      prefixIcon: Icon(Icons.email_outlined),
                      contentPadding: EdgeInsets.only(top: 5),
                    ),
                  ),
                  SizedBox(height: 15,),
                  //==========password text field==============
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      contentPadding: EdgeInsets.only(top: 5),
                    ),
                  ),
                ],
              )),

            //=======forget password text button=====
            Align(
              heightFactor: 2,
              alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
//========Bottom sheet screen ===============
                 showModalBottomSheet(context: context,
                     builder: (context)=> Container(
                       padding: EdgeInsets.all(30),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Make Selection!",style: TextStyle(fontSize:
                           20,fontWeight: FontWeight.bold),),
                           Text("Selection one of the option given below to "
                               "reset your password"),
                           SizedBox(height: 20,),

                           //=====Email - reset password container=====
                           ForgetPasswordBottomWidget(title: 'E-Mail', subtitle: 'Reset via E-Mail Verification"',
                             iconData: Icons.email_outlined, ontap: () {

                             Navigator.pop(context);
                             Navigator.push(context, MaterialPageRoute
                               (builder: (context)=> ForgetPasswordEmailScreen()));
                             },),
                           SizedBox(height: 15,),

                           //==phone number reset password container =====
                           ForgetPasswordBottomWidget(title: "Phone Number",
                               subtitle: "Reset via Phone no verification",
                               iconData: Icons
                                   .phone_android_outlined, ontap: () {
                               Navigator.pop(context);
                               Navigator.push(context, MaterialPageRoute
                                 (builder: (context)=> ForgetPasswordPhoneNumberScreen()));
                             },)


                         ],
                       ),
                     ));

                   },
                    child: Text("Forget PassWord ",style: TextStyle(color: Colors.blue),))),
            SizedBox(height: 20,),

            // ===========login button ==============
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(width: 15,),
                    Text("Login ",style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),

            // =======Dont have an account button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Don't have an account ? "),
              Text("Sign-up",style: TextStyle(color: Colors.blue),)
            ],),
             SizedBox(height: 10,),

             //=========divider ==================
             Row(
              children: [
                Expanded(child: Divider(color: Colors.grey,thickness: 1,)),
                Text("  Or  "),
                Expanded(child: Divider(color: Colors.grey,thickness: 1,)),

              ],
            ),

            SizedBox(height: 30,),
            //========continue with google ======
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage(loginGoogleImage),height: 30,width: 30,),
                    SizedBox(width: 15,),
                    Text("Continue with Google",style: TextStyle(fontSize: 18),)
                  ],
                ),),
            ),



          ],
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordBottomWidget extends StatelessWidget {
   ForgetPasswordBottomWidget({
     required this.title,required this.subtitle,required this.iconData,
     required this.ontap,
    super.key,

  });
  String title,subtitle;
  IconData iconData;
  Callback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade300
        ),
        child: Row(
          children: [
            Icon(iconData,size: 35,),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: TextStyle(fontSize:
                20,fontWeight: FontWeight.bold),),
                Text(subtitle)
              ],
            )
          ],
        ),
      ),
    );
  }
}
