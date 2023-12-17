import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pgroom/src/model/tiffin_services_model/tiffen_services_model.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/helpers/helper_function.dart';

class ApisClass {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //to return current user info
  static User get user => auth.currentUser!;

  // for accessing cloud firestorm database
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // for storing Image  information
  static FirebaseStorage storage = FirebaseStorage.instance;

  //current date and time
  static final time = DateTime.now().microsecondsSinceEpoch.toString();

  static var coverImageDownloadUrl;
  static var userRentId = "";
  static var tiffineServicesId = '';
  static var tiffineServicesUrl = '';
  static var foodMenuUrl = '';
  static var userName;
  static var otherDownloadUrl;
  static var userEmail;
  static var userCity;
  static var userImage = "";
  static var reviewId = "";
  static var tiffineReviewId = "";

  static var starOne;

  static var starTwo;

  static var starThree;

  static var starFour;

  static var starFive;

  static var starOneTiffine;

  static var starTwoTiffine;

  static var starThreeTiffine;

  static var starFourTiffine;

  static var starFiveTiffine;

  static var averageRatingTiffine;
  static var totalNumberOfStarTiffine;

  static var averageRating;
  static var totalNumberOfStar;
  static var userImageDownloadUrl = '';

  static UserRentModel model = UserRentModel();
  static List<UserRentModel> allDataList = [];

  //============ Post Room  Data Apis =====================

  //upload data in firebase for home screen list
  // in list all data in one collection
  static Future rentDetailsHomeList(
      coverImage,
      houseName,
      address,
      cityName,
      landMark,
      contactNumber,
      bhk,
      roomType,
      singlePrice,
      doublePrice,
      triplePrice,
      fourPrice,
      familyPrice,
      restrictedTime,
      numberOfRooms,
      wifi,
      bed,
      chair,
      table,
      fan,
      gadda,
      light,
      locker,
      bedSheet,
      washingMachine,
      parking,
      electricityBill,
      waterBill,
      flexible,
      cooking,
      cookingType,
      boyAllow,
      girlAllow,
      familyMember,
      attachBathRoom,
      shareAbleBathRoom,
      like) async {
    final userHomeList = UserRentModel(
        coverImage: coverImage,
        houseName: houseName,
        address: address,
        city: cityName,
        landMark: landMark,
        contactNumber: contactNumber,
        bhkType: bhk,
        roomType: roomType,
        singlePersonPrice: singlePrice,
        doublePersonPrice: doublePrice,
        triplePersonPrice: triplePrice,
        fourPersonPrice: fourPrice,
        familyPrice: familyPrice,
        numberOfRooms: numberOfRooms,
        wifi: wifi,
        bed: bed,
        chair: chair,
        table: table,
        fan: fan,
        gadda: gadda,
        light: light,
        locker: locker,
        bedSheet: bedSheet,
        washingMachine: washingMachine,
        parking: parking,
        electricityBill: electricityBill,
        waterBill: waterBill,
        flexibleTime: flexible,
        cooking: cooking,
        cookingType: cookingType,
        boy: boyAllow,
        girls: girlAllow,
        familyMember: familyMember,
        like: like,
        restrictedTime: restrictedTime,
        attachBathRoom: attachBathRoom,
        shareAbleBathRoom: shareAbleBathRoom,
        average: 0.0,
        numberOfRating: 0,
        roomAvailable: true,
        userRentId: time);
    return await firebaseFirestore.collection("rentCollection").doc(userRentId).set(userHomeList.toJson());
  }

  // this data store in data in user profile specific

  static Future<DocumentReference<Map<String, dynamic>>?> rentDetailsUser(
      coverImage,
      houseName,
      address,
      cityName,
      landMark,
      contactNumber,
      bhk,
      roomType,
      singlePrice,
      doublePrice,
      triplePrice,
      fourPrice,
      familyPrice,
      restrictedTime,
      numberOfRooms,
      wifi,
      bed,
      chair,
      table,
      fan,
      gadda,
      light,
      locker,
      bedSheet,
      washingMachine,
      parking,
      electricityBill,
      waterBill,
      flexible,
      cooking,
      cookingType,
      boyAllow,
      girlAllow,
      familyMember,
      attachBathRoom,
      shareAbleBathRoom,
      like) async {
    final userHomeList = UserRentModel(
        coverImage: coverImage,
        houseName: houseName,
        address: address,
        city: cityName,
        landMark: landMark,
        contactNumber: contactNumber,
        bhkType: bhk,
        roomType: roomType,
        singlePersonPrice: singlePrice,
        doublePersonPrice: doublePrice,
        triplePersonPrice: triplePrice,
        fourPersonPrice: fourPrice,
        familyPrice: familyPrice,
        numberOfRooms: numberOfRooms,
        wifi: wifi,
        bed: bed,
        chair: chair,
        table: table,
        fan: fan,
        gadda: gadda,
        light: light,
        locker: locker,
        bedSheet: bedSheet,
        washingMachine: washingMachine,
        parking: parking,
        electricityBill: electricityBill,
        waterBill: waterBill,
        flexibleTime: flexible,
        cooking: cooking,
        cookingType: cookingType,
        boy: boyAllow,
        girls: girlAllow,
        familyMember: familyMember,
        like: like,
        restrictedTime: restrictedTime,
        attachBathRoom: attachBathRoom,
        shareAbleBathRoom: shareAbleBathRoom,
        average: 0.0,
        numberOfRating: 0,
        roomAvailable: true,
        userRentId: time);

    return await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .add(userHomeList.toJson())
        .then((value) {
      AppLoggerHelper.info(value.id);
      userRentId = value.id;
      return null;
    });
  }

  // upload  Cover image data in firebase database
  static Future uploadCoverImage(File imageFile) async {
    try {
      final reference = storage.ref().child('coverImage/${user.uid}/${DateTime.now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      coverImageDownloadUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

//=========================================================

//============== Edit Post Room Data APis ===================

  //upload other images in firebase database
  static Future uploadOtherImage(File imageFile, itemId) async {
    try {
      final reference = storage.ref().child('otherImage/${DateTime.now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      otherDownloadUrl = await snapshot.ref.getDownloadURL();
      //rent collection data base
      await firebaseFirestore
          .collection("OtherImageUserList")
          .doc(itemId)
          .collection("$itemId")
          .add({'OtherImage': otherDownloadUrl}).then((value) async {
        AppLoggerHelper.info(value.id);
        userRentId = value.id;
//user personal collection data base
        await firebaseFirestore
            .collection("OtherImageList")
            .doc(itemId)
            .collection("$itemId")
            .doc(userRentId)
            .set({'OtherImage': otherDownloadUrl});

        return null;
      });
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

// update cover Image data
  static Future<void> updateCoverItemImage(File file, String itemId) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('coverImage/${user.uid}.$ext');

    // uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      AppLoggerHelper.info('Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    model.coverImage = await ref.getDownloadURL();

    //rent collection data base
    await firebaseFirestore.collection('rentCollection').doc(itemId).update({'coverImage': model.coverImage});
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'coverImage': model.coverImage});
  }

  //update Permission data
  static Future<void> updatePermissionData(itemId, cookingType, cooking, boy, girl, familyMember) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update(
        {'girls': girl, 'boy': boy, 'cooking': cooking, 'cookingType': cookingType, 'familyMember': familyMember});
//user personal collection data base
    await firebaseFirestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update(
        {'girls': girl, 'boy': boy, 'cooking': cooking, 'cookingType': cookingType, 'familyMember': familyMember});
  }

  // update provide Facilities Data
  static Future<void> updateProvideFacilitiesData(itemId, wifi, bed, chair, table, fan, gadda, light, locker, bedSheet,
      washingMachine, parking, attachBathroom, shareableBathroom) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({
      'parking': parking,
      'bed': bed,
      'washingMachine': washingMachine,
      'locker': locker,
      'fan': fan,
      'gadda': gadda,
      'table': table,
      'wifi': wifi,
      'chair': chair,
      'bedSheet': bedSheet,
      'light': light,
      'attachBathRoom': attachBathroom,
      'shareAbleBathRoom': shareableBathroom,
    });
//user personal collection data base
    await firebaseFirestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update({
      'parking': parking,
      'bed': bed,
      'washingMachine': washingMachine,
      'locker': locker,
      'fan': fan,
      'gadda': gadda,
      'table': table,
      'wifi': wifi,
      'chair': chair,
      'bedSheet': bedSheet,
      'light': light,
      'attachBathRoom': attachBathroom,
      'shareAbleBathRoom': shareableBathroom,
    });
  }

  // update Additional Charges And Door closing time
  static Future<void> updateAdditionalChargesAndDoorDate(itemId, electricity, water, restrictTime, flexibleTime) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({
      'flexibleTime': flexibleTime,
      'restrictedTime': restrictTime,
      'waterBill': water,
      'electricityBill': electricity,
    });
//user personal collection data base
    await firebaseFirestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update({
      'flexibleTime': flexibleTime,
      'restrictedTime': restrictTime,
      'waterBill': water,
      'electricityBill': electricity,
    });
  }

  //update Rent Details data
  static Future<void> updateRentDetailsData(name, address, city, landMark, number, numberOfRoom, itemID) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemID).update({
      'houseName': name,
      'contactNumber': number,
      'landMark': landMark,
      'city': city,
      'address': address,
      'numberOfRooms': numberOfRoom
    });
//user personal collection data base
    await firebaseFirestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemID).update({
      'houseName': name,
      'contactNumber': number,
      'landMark': landMark,
      'city': city,
      'address': address,
      'numberOfRooms': numberOfRoom
    });
  }

  // update Room type And Price Data
  static Future<void> updateRoomTypeAndPrice(itemId, single, double, triple, four, family) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({
      'doublePersonPrice': double,
      'triplePersonPrice': triple,
      'familyPrice': family,
      'fourPersonPrice': four,
      'singlePersonPrice': single
    });
//user personal collection data base
    await firebaseFirestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update({
      'doublePeronPrice': double,
      'triplePersonPrice': triple,
      'familyPrice': family,
      'fourPersonPrice': four,
      'singlePersonPrice': single
    });
  }

  static Future<void> updateRoomAvailable(roomAvailable, itemId) async {
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({'roomAvailable': roomAvailable});
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'roomAvailable': roomAvailable});
  }

//=========================================================

//============== User Data  Apis ===========================

  //Get all data in user
  static Future<void> getUserData() async {
    var collection = firebaseFirestore.collection('loginUser').doc(user.uid).collection(user.uid).doc(user.uid);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    userName = data?['Name'] ?? '';
    userCity = data?['city'] ?? '';
    userEmail = data?['email'] ?? '';
    userImage = data?['userImage'] ?? '';
  }

  // save a user data
  static Future<void> saveUserData(name, city, email, image) async {
    await firebaseFirestore.collection("loginUser").doc(user.uid).collection(user.uid).doc(user.uid).set({
      'city': city,
      'email': email,
      'Name': name,
      'userImage': image,
    });
  }

  static Future<void> updateUserData(name, city) async {
    await firebaseFirestore.collection("loginUser").doc(user.uid).collection(user.uid).doc(user.uid).update({
      'city': city,
      'Name': name,
    });
  }

  //upload user images in firebase database
  static Future<String> uploadUserImage(File imageFile) async {
    try {
      final reference = storage.ref().child('userImage/${user.uid}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      userImageDownloadUrl = await snapshot.ref.getDownloadURL();

      await firebaseFirestore.collection('loginUser').doc(user.uid).update({'userImage': userImageDownloadUrl});
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
    return userImageDownloadUrl;
  }

  // update user Image data
  static Future<void> updateUserImage(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('userImage/${user.uid}.$ext');

    // uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      AppLoggerHelper.info('Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    var updateUserImage = await ref.getDownloadURL();

    await firebaseFirestore
        .collection('loginUser')
        .doc(user.uid)
        .collection(user.uid)
        .doc(user.uid)
        .update({'userImage': updateUserImage});

    //rent collection data base
  }

//=========================================================

  //============= Rating bar Summary Apis===================

  //Get in user rating bar summary data
  static Future<void> getRatingBarSummaryData(itemId) async {
    var collection = firebaseFirestore
        .collection("userReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    starOne = data?['ratingStar01'] ?? 0;
    starTwo = data?['ratingStar02'] ?? 0;
    starThree = data?['ratingStar03'] ?? 0;
    starFour = data?['ratingStar04'] ?? 0;
    starFive = data?['ratingStar05'] ?? 0;
    totalNumberOfStar = data?['totalNumberOfStar'] ?? 0;
    averageRating = data?['averageRating'] ?? 0.0;
  }

  //save Rating Summary data
  static Future<void> saveRatingBarSummaryData(itemId, one, two, three, four, five, avg, totalNumberOfStar) async {
    //Rating Summary data
    await firebaseFirestore
        .collection("userReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId)
        .set({
      'ratingStar01': one,
      'ratingStar02': two,
      'ratingStar03': three,
      'ratingStar04': four,
      'ratingStar05': five,
      'totalNumberOfStar': totalNumberOfStar,
      'averageRating': avg,
    });
  }

  //update Rating bar summary data
  static Future<void> updateRatingBarStarSummaryData(itemId, avg, totalNumberOfStar) async {
    //Rating Summary data
    await firebaseFirestore
        .collection("userReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId)
        .update({
      'totalNumberOfStar': totalNumberOfStar,
      'averageRating': avg,
    }).then((value) {
      AppLoggerHelper.info("Update Rating bar average successfully");
    }).onError((error, stackTrace) {
      AppLoggerHelper.error("Update Rating bar average successfully");
    });
  }

//=========================================================

//============== Review Apis ==============================

  //get review id for check user a review submit or not
  static Future<String> getReviewData(itemId) async {
    var collection =
        firebaseFirestore.collection("loginUser").doc(user.uid).collection(auth.currentUser!.uid).doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    reviewId = data?['itemId'] ?? '';
    return reviewId;
  }

  /// Rating and review create api
  static Future<void> ratingAndReviewCreateData(ratingStar, review, itemId) async {
    //This review data save in all viewer user
    await firebaseFirestore.collection("userReview").doc("reviewCollection").collection("$itemId").add({
      'rating': ratingStar,
      'title': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': ApisClass.userName,
      'userImage': ApisClass.userImage
    });

    // This review  data save in user account only
    await firebaseFirestore.collection("loginUser").doc(user.uid).collection(auth.currentUser!.uid).doc(itemId).set({
      'itemId': itemId,
      'rating': ratingStar,
      'title': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': ApisClass.userName,
      'userImage': ApisClass.userImage
    });
  }

  //add ratings in  user collection  and rent list collection
  static Future<void> addRatingMainList(itemId, average, numberOfRating) async {
    //rent collection data base
    await firebaseFirestore
        .collection("rentCollection")
        .doc(itemId)
        .update({'average': average, 'numberOfRating': numberOfRating});
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'average': average, 'numberOfRating': numberOfRating});
  }

  //=======================================================

//============== Share preference =========================

  //Remove user in share preferences
  static Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }

//=========================================================

//============== Deletes data apis =========================

  // delete cover image  data and all list collection data  code
  static Future<void> deleteCoverImageData(String deleteId, String imageUrl) async {
    try {
      //delete a Firestorm
      DocumentReference documentReference =
          firebaseFirestore.collection('userRentDetails').doc(user.uid).collection(user.uid).doc(deleteId);

      DocumentReference documentReference1 = firebaseFirestore.collection('rentCollection').doc(deleteId);

      //Rating Summary data
      await firebaseFirestore
          .collection("userReview")
          .doc("reviewCollection")
          .collection("$deleteId")
          .doc(deleteId)
          .collection("reviewSummary")
          .doc(deleteId)
          .delete();

      // This review  data save in user account only
      await firebaseFirestore
          .collection("loginUser")
          .doc(user.uid)
          .collection(auth.currentUser!.uid)
          .doc(deleteId)
          .delete();

      //delete a review collection data

      final batch = firebaseFirestore.batch();
      var collection = firebaseFirestore.collection("userReview").doc("reviewCollection").collection(deleteId);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      // Delete the document.
      await documentReference.delete();
      await documentReference1.delete();

      // delete a firestorm image data
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

  //delete Other image data
  static Future<void> deleteOtherImage(String deleteOtherIMageId, String itemId, String imageUrl) async {
    try {
      DocumentReference documentReference =
          firebaseFirestore.collection("OtherImageUserList").doc(itemId).collection(itemId).doc(deleteOtherIMageId);

      DocumentReference documentReference1 =
          firebaseFirestore.collection("OtherImageList").doc(itemId).collection(itemId).doc(deleteOtherIMageId);

      await documentReference.delete();
      await documentReference1.delete();

      // delete a firestorm image data
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

  static Future<void> deleteTiffineServicesData(String deleteId) async {
    try {
      //delete a Firestorm
      DocumentReference documentReference =
          firebaseFirestore.collection('userTiffineCollection').doc(user.uid).collection(user.uid).doc(deleteId);

      DocumentReference documentReference1 = firebaseFirestore.collection('tiffineServicesCollection').doc(deleteId);

      // //Rating Summary data
      // await firebaseFirestore
      //     .collection("userReview")
      //     .doc("reviewCollection")
      //     .collection("$deleteId")
      //     .doc(deleteId)
      //     .collection("reviewSummary")
      //     .doc(deleteId)
      //     .delete();

      //   // This review  data save in user account only
      //   await firebaseFirestore
      //       .collection("loginUser")
      //       .doc(user.uid)
      //       .collection(auth.currentUser!.uid)
      //       .doc(deleteId)
      //       .delete();
      //
      //   //delete a review collection data
      //
      //   final batch = firebaseFirestore.batch();
      //   var collection = firebaseFirestore.collection("userReview").doc("reviewCollection").collection(deleteId);
      //   var snapshots = await collection.get();
      //   for (var doc in snapshots.docs) {
      //     batch.delete(doc.reference);
      //   }
      //   await batch.commit();
      //
      //   // Delete the document.
      await documentReference.delete();
      await documentReference1.delete();
      //
      //   // delete a firestorm image data
      //   final ref = storage.refFromURL(imageUrl);
      //   await ref.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

//=========================================================

//==============Tiffine Services Apis =====================

  static Future<void> addYourTiffineServices(coverImage, servicesName, address, price, menuImage) async {
    final tiffineList = TiffineServicesModel(
      address: address,
      averageRating: 0.0,
      foodImage: coverImage,
      foodPrice: price,
      menuImage: menuImage,
      numberOfRating: 0,
      servicesName: servicesName,
    );

    return await firebaseFirestore
        .collection("tiffineServicesCollection")
        .doc(tiffineServicesId)
        .set(tiffineList.toJson());
  }

  static Future<void> addYourTiffineServicesUserAccount(coverImage, servicesName, address, price, menuImage) async {
    final tiffineList = TiffineServicesModel(
      address: address,
      averageRating: 0.0,
      foodImage: coverImage,
      foodPrice: price,
      menuImage: menuImage,
      numberOfRating: 0,
      servicesName: servicesName,
    );

    return await firebaseFirestore
        .collection("userTiffineCollection")
        .doc(user.uid)
        .collection(user.uid)
        .add(tiffineList.toJson())
        .then((value) {
      AppLoggerHelper.info(value.id);
      tiffineServicesId = value.id;
      return null;
    });
  }

  // upload  Cover image data in firebase database
  static Future uploadTiffineServicesImage(File imageFile) async {
    try {
      final reference = storage.ref().child('tiffineServices/${user.uid}/${DateTime.now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      tiffineServicesUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

  // upload  Cover image data in firebase database
  static Future uploadMenuImage(File imageFile) async {
    try {
      final reference = storage.ref().child('foodMenu/${user.uid}/${DateTime.now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      foodMenuUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

//=========================================================

//==============Edit  Tiffine Services Apis ===============

  //update Rent Details data
  static Future<void> updateTiffineServicesData(servicesName, address, price, itemId) async {
    //rent collection data base
    await firebaseFirestore.collection("tiffineServicesCollection").doc(itemId).update({
      'foodPrice': price,
      'address': address,
      'servicesName': servicesName,
    });
//user personal collection data base
    await firebaseFirestore.collection("userTiffineCollection").doc(user.uid).collection(user.uid).doc(itemId).update({
      'foodPrice': price,
      'address': address,
      'servicesName': servicesName,
    });
  }

  // update cover Image data

  // update cover Image data
  static Future<void> updateTiffineCoverImage(File file, String itemId) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('tiffineServices/${user.uid}.$ext');

    // uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      AppLoggerHelper.info('Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    final tiffineUrl = await ref.getDownloadURL();

    //rent collection data base
    await firebaseFirestore.collection('tiffineServicesCollection').doc(itemId).update({
      'foodImage': tiffineUrl,
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userTiffineCollection")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'foodImage': tiffineUrl});
  }

  // update cover Image data
  static Future<void> updateTiffineMenuImage(File file, String itemId) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('foodMenu/${user.uid}.$ext');

    // uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      AppLoggerHelper.info('Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    final tiffineMenuUrl = await ref.getDownloadURL();

    //rent collection data base
    await firebaseFirestore.collection('tiffineServicesCollection').doc(itemId).update({
      'menuImage': tiffineMenuUrl,
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userTiffineCollection")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'menuImage': tiffineMenuUrl});
  }

//=========================================================





//============== Review Apis ==============================

  //get review id for check user a review submit or not
  static Future<String> getReviewTiffineData(itemId) async {
    var collection =
    firebaseFirestore.collection("loginUser").doc(user.uid).collection(auth.currentUser!.uid).doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    tiffineReviewId = data?['tiffineUserId']??'';

    return tiffineReviewId;
  }

  /// Rating and review create api
  static Future<void> ratingAndReviewCreateTiffineData(ratingStar, review, itemId) async {
    //This review data save in all viewer user
    await firebaseFirestore.collection("TiffineReview").doc("reviewCollection").collection("$itemId").add({
      'rating': ratingStar,
      'title': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': ApisClass.userName,
      'userImage': ApisClass.userImage
    });

    // This review  data save in user account only
    await firebaseFirestore.collection("loginUser").doc(user.uid).collection(auth.currentUser!.uid).doc(itemId).set({
      'tiffineUserId': itemId,
      'tiffineRating': ratingStar,
      'tiffineTitle': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': ApisClass.userName,
      'userImage': ApisClass.userImage
    });
  }

  //add ratings in  user collection  and Tiffine list collection
  static Future<void> addRatingMainTiffineList(itemId, average, numberOfRating) async {
    //rent collection data base
    await firebaseFirestore
        .collection("tiffineServicesCollection")
        .doc(itemId)
        .update({'averageRating': average, 'NumberOfRating': numberOfRating});
//user personal collection data base
    await firebaseFirestore
        .collection("userTiffineCollection")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'averageRating': average, 'NumberOfRating': numberOfRating});
  }






  //============= Rating bar Summary Apis===================

  //Get in user rating bar summary data
  static Future<void> getRatingBarSummaryTiffineData(itemId) async {
    var collection = firebaseFirestore
        .collection("TiffineReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    starOneTiffine = data?['ratingStar01'] ?? 0;
    starTwoTiffine = data?['ratingStar02'] ?? 0;
    starThreeTiffine = data?['ratingStar03'] ?? 0;
    starFourTiffine = data?['ratingStar04'] ?? 0;
    starFiveTiffine = data?['ratingStar05'] ?? 0;
    totalNumberOfStarTiffine = data?['totalNumberOfStar'] ?? 0;
    averageRatingTiffine = data?['averageRating'] ?? 0.0;
  }

  //save Rating Summary data
  static Future<void> saveRatingBarSummaryTiffineData(itemId, one, two, three, four, five, avg, totalNumberOfStar)
  async {
    //Rating Summary data
    await firebaseFirestore
        .collection("TiffineReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId)
        .set({
      'ratingStar01': one,
      'ratingStar02': two,
      'ratingStar03': three,
      'ratingStar04': four,
      'ratingStar05': five,
      'totalNumberOfStar': totalNumberOfStar,
      'averageRating': avg,
    });
  }

  //update Rating bar summary data
  static Future<void> updateRatingBarStarSummaryTiffineData(itemId, avg, totalNumberOfStar) async {
    //Rating Summary data
    await firebaseFirestore
        .collection("TiffineReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId)
        .update({
      'totalNumberOfStar': totalNumberOfStar,
      'averageRating': avg,
    }).then((value) {
      AppLoggerHelper.info("Update Rating bar average successfully");
    }).onError((error, stackTrace) {
      AppLoggerHelper.error("Update Rating bar average successfully");
    });
  }



}
