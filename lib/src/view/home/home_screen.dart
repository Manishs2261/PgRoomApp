
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/uitels/Constants/colors.dart';
import 'package:pgroom/src/uitels/logger/logger.dart';
import 'package:pgroom/src/view/home/widgets/AppBarWIdgets.dart';
import 'package:pgroom/src/view/home/widgets/ItemListView.dart';
import '../../model/user_rent_model/user_rent_model.dart';
import '../drawer_screen/drawer_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<UserRentModel> rentList = [];
  var snapData;

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("home build : Home Screen");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RoutesName.loginScreen);
        },
      ),
      //==preferrendSize provide a maximum appbar length
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
              children: [
                //=======App bar code ====================
                const AppBarWIdgets(),
                //========search field code ==============
                Container(
                  color: AppColors.primary,
                  height: 62,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 5,
                    ),
                    child: TextFormField(
                      onTap: () {
                        Get.toNamed(RoutesName.searchScreen, arguments: {
                          'list': rentList,
                          'id': snapData,
                        });
                      },
                      autofocus: false,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        fillColor: Colors.yellow[50],
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter Locality / Landmark / Colony",
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: const Icon(Icons.mic),
                        isDense: false,
                        contentPadding: const EdgeInsets.only(
                          bottom: 5,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
        ),


      //======drawer code ===============
      drawer: const DrawerScreen(),
      //=======list view builder code==============
      body: StreamBuilder(
          stream: ApisClass.firestore.collection('rentCollection').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.signal_wifi_connected_no_internet_4),
                      Text("No Internet Connection"),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        color: Colors.blue,
                      )
                    ],
                  ),
                );
              case ConnectionState.none:
                return const Center(
                  child: Row(
                    children: [
                      Icon(Icons.signal_wifi_connected_no_internet_4),
                      Text("No Internet Connection"),
                      CircularProgressIndicator(
                        color: Colors.blue,
                      )
                    ],
                  ),
                );

              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;

                // for(var i in data!)
                //   {
                //     log("Data : ${jsonEncode(i.data())}");
                //   }

                snapData = snapshot;
                rentList = data?.map((e) => UserRentModel.fromJson(e.data())).toList() ?? [];

                return ItemListView(
                  rentList: rentList,
                  snapshot: snapshot,
                );
            }
          }),
    );
  }
}
