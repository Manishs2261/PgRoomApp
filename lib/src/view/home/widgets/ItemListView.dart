import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/uitels/Constants/colors.dart';
import '../../../model/user_rent_model/user_rent_model.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../uitels/helpers/heiper_function.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({
    super.key,
    required this.rentList,
    this.snapshot,
  });

  final List<UserRentModel> rentList;
  final snapshot;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 0.2, right: 0.2),
        itemCount: rentList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              final itemId = snapshot.data?.docs[index].id;

              Get.toNamed(RoutesName.detailsRentInfoScreen, arguments: {
                'list': rentList[index],
                'id': itemId,
              });
            },
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: dark ? AppColors.dark : const Color.fromRGBO(200, 200, 40, 0.01),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 0.2,
                    )
                  ]),
              child: Row(
                children: [
                  //====== front image========
                  Container(
                    width: 150,
                    height: 280,
                    color: dark ? Colors.blueGrey.shade900 : Colors.grey.shade200,
                    
                    child: CachedNetworkImage(

                      imageUrl: '${rentList[index].coverImage}',
                      fit: BoxFit.fill,

                        placeholder: (context, url) => Container(
                          color:  Colors.transparent,
                          height: 100,
                          width: 100,
                          child: SpinKitFadingCircle(
                            color: AppColors.primary,
                            size: 35,
                          ),
                        ),
                      errorWidget: (context, url, error) =>  Container(
                        width: 150,
                        height: 280,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_outlined,size: 50,),
                      )
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),
                  // =====Details ============

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            "${rentList[index].houseName}",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 17,
                            ),
                            Text("${rentList[index].review}"),
                            const Text(" (28 reviews)")
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Rent - ₹',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${rentList[index].singlePersonPrice}',
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                              const TextSpan(text: ' /- monthly'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Flexible(
                          child: Text(
                            "${rentList[index].addres} ",
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text("city - ${rentList[index].city}"),
                        Text("Room Type - ${rentList[index].roomType}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
