import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:interactive/core/route/app_route.dart';
import 'package:interactive/model/user_model.dart';
import 'package:interactive/utils/app_color.dart';
import 'package:interactive/utils/app_string.dart';

class AppBarSection extends StatelessWidget {
  AppBarSection({super.key});
  final FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
        border: Border.all(color: AppColors.pink20),
      ),
      child: FutureBuilder<DocumentSnapshot>(
        future: firebaseFirestore.collection('users').doc(firebaseAuth.currentUser?.uid??"").get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.hasError) {
            return const Center(child: Text(AppString.somethingWentWrong));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading..."));
          }
          Map<String,dynamic> userData = snapshot.data?.data() as Map<String, dynamic>;
          UserModel userModel = UserModel.fromJson(userData);
          return ListTile(
            leading: SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: "https://www.pngall.com/wp-content/uploads/5/Profile-Male-PNG.png",
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.person,
                    color: AppColors.pink100,
                  ),
                ),
              ),
            ),
            title: Text(userModel.name??"",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(userModel.email??""),
            trailing: GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(AppString.logOut),
                  content:
                  const Text(AppString.areYouSureDoYouWantToLogout),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actionsPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
                  actions: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 3),
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        child: const Text(AppString.cancel),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width / 3),
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                            await firebaseAuth.signOut();
                            Fluttertoast.showToast(msg: 'LogOut Successful');
                            Get.offAndToNamed(AppRoute.loginScreen);
                          } catch (error) {
                            Fluttertoast.showToast(msg: "Error LogOut");
                          }
                        },
                        child: const Text(AppString.logOut),
                      ),
                    ),
                  ],
                ),
              ),
              child: const Icon(Icons.logout),
            ),
          );
        },
      ),
    );
  }
}
