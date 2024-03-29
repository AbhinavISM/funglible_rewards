import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flipgrid/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';

import 'models/transaction.dart';
import 'services/functions.dart';
import 'utils/constants.dart';

Future<void> _launchSocialMediaAppIfInstalled({
  required String url,
}) async {
  try {
    bool launched =
        await launch(url, forceSafariVC: false); // Launch the app if installed!

    if (!launched) {
      await launch(url); // Launch web view if app is not installed!
    }
  } catch (e) {
    await launch(url); // Launch web view if app is not installed!
  }
}

const List<String> socialMediaUrls = [
  "https://www.instagram.com/flipkart/?hl=en",
  "https://www.facebook.com/flipkart/",
  "https://twitter.com/flipkart?lang=en",
];
const List<String> socialMediaPlatforms = ["Instagram", "Facebook", "Twitter"];

class FollowToEarn extends StatefulWidget {
  // final String title;
  const FollowToEarn({super.key});

  @override
  State<FollowToEarn> createState() => _FollowToEarnState();
}

class _FollowToEarnState extends State<FollowToEarn> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width * 0.6,
          height: height * 0.6,
          child: const SingleChildScrollView(child: FollowOnSocials()),
        ),
      ),
    );
  }
}

class FollowOnSocials extends StatefulWidget {
  const FollowOnSocials({super.key});

  @override
  State<FollowOnSocials> createState() => _FollowOnSocialsState();
}

class _FollowOnSocialsState extends State<FollowOnSocials> {
  Client? client;
  Web3Client? ethClient;

  void showSocialMediaReward() async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: "Social Media Interaction",
      widget: const Column(
        children: [
          Text("You are awarded 1 Token"),
        ],
      ),
      confirmBtnText: "Claim Reward!",
      onConfirmBtnTap: () {
        Navigator.pop(context);
      },
      barrierDismissible: false,
    );
  }

  @override
  void initState() {
    client = Client();
    ethClient = Web3Client(infura_url, client!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Follow Us On : "),
        const Padding(padding: EdgeInsets.only(top: 8)),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(children: [
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final user =
                        ref.watch(currentUserStateProvider);
                    return ElevatedButton(
                      onPressed: () async {
                        if ( index == 0&&!user.getCurrentUser.instaFollowed) {
                           print("follow insta");
                          await _launchSocialMediaAppIfInstalled(
                              url: socialMediaUrls[index]);
                          user.setCurrentUser =
                              user
                                  .getCurrentUser
                                  .copyWith(instaFollowed: true,
                                  tokens: user
                                  .getCurrentUser.tokens+1
                              );
                          print(user.getCurrentUser.toJson());
                          await FirebaseFirestore.instance
                              .collection("Customers")
                              .doc(user.getCurrentUser.email)
                              .set(user.getCurrentUser.toJson());
                          final transaction = TransactionAppModel(
                              dateTime: DateTime.now(),
                              amountRecieved: null,
                              tokensRecieved: 1,
                              tokensSpent: null,
                              amountSpent: null,
                              senderAdress: null,
                              recieverAress: user.getCurrentUser.customerAddress,
                              customerEmail: user.getCurrentUser.email,
                              title: 'followed us on insta');
                          await FirebaseFirestore.instance
                              .collection("Transactions")
                              .doc()
                              .set(transaction.toJson());
                           showSocialMediaReward();
                          await ServiceClass().mintDailyCheckInLoyaltyPoints(
                              user.getCurrentUser.customerAddress, ethClient!);
                        }
                        else if (index==1&&!user.getCurrentUser.fbFollowed) {
                          await _launchSocialMediaAppIfInstalled(
                              url: socialMediaUrls[index]);
                          user.setCurrentUser =
                              user
                                  .getCurrentUser
                                  .copyWith(fbFollowed: true,
                                  tokens: user
                                      .getCurrentUser.tokens+1
                              );
                          print(user.getCurrentUser.toJson());
                          await FirebaseFirestore.instance
                              .collection("Customers")
                              .doc(user.getCurrentUser.email)
                              .set(user.getCurrentUser.toJson());
                          final transaction = TransactionAppModel(
                              dateTime: DateTime.now(),
                              amountRecieved: null,
                              tokensRecieved: 1,
                              tokensSpent: null,
                              amountSpent: null,
                              senderAdress: null,
                              recieverAress: user.getCurrentUser.customerAddress,
                              customerEmail: user.getCurrentUser.email,
                              title: 'followed us on fb');
                          await FirebaseFirestore.instance
                              .collection("Transactions")
                              .doc()
                              .set(transaction.toJson());
                          showSocialMediaReward();
                          await ServiceClass().mintDailyCheckInLoyaltyPoints(
                              user.getCurrentUser.customerAddress, ethClient!);
                        } else if (index == 2&& !user.getCurrentUser.twitterFollowed ) {
                          await _launchSocialMediaAppIfInstalled(
                              url: socialMediaUrls[index]);
                          user.setCurrentUser =
                              user
                                  .getCurrentUser
                                  .copyWith(twitterFollowed: true,
                                  tokens: user
                                      .getCurrentUser.tokens+1
                              );
                          print(user.getCurrentUser.toJson());
                          await FirebaseFirestore.instance
                              .collection("Customers")
                              .doc(user.getCurrentUser.email)
                              .set(user.getCurrentUser.toJson());
                          final transaction = TransactionAppModel(
                              dateTime: DateTime.now(),
                              amountRecieved: null,
                              tokensRecieved: 1,
                              tokensSpent: null,
                              amountSpent: null,
                              senderAdress: null,
                              recieverAress: user.getCurrentUser.customerAddress,
                              customerEmail: user.getCurrentUser.email,
                              title: 'followed us on twitter');
                          await FirebaseFirestore.instance
                              .collection("Transactions")
                              .doc()
                              .set(transaction.toJson());
                          showSocialMediaReward();
                          await ServiceClass().mintDailyCheckInLoyaltyPoints(
                              user.getCurrentUser.customerAddress, ethClient!);
                        }
                      },
                      child: Text(socialMediaPlatforms[index]),
                    );
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
              ]);
            })
      ],
    );
  }
}
