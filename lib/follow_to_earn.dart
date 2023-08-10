import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchSocialMediaAppIfInstalled({
  required String url,
}) async {
  try {
    bool launched =
        await launch(url, forceSafariVC: false); // Launch the app if installed!

    if (!launched) {
      launch(url); // Launch web view if app is not installed!
    }
  } catch (e) {
    launch(url); // Launch web view if app is not installed!
  }
}

const List<String> socialMediaUrls = [
  "https://www.facebook.com/avinave.agrwal/",
  "https://www.facebook.com/avinave.agrwal/",
  "https://www.facebook.com/avinave.agrwal/",
  "https://www.facebook.com/avinave.agrwal/"
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

class FollowOnSocials extends StatelessWidget {
  const FollowOnSocials({super.key});

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
                ElevatedButton(
                  onPressed: () => {
                    _launchSocialMediaAppIfInstalled(
                        url: socialMediaUrls[index])
                  },
                  child: Text(socialMediaPlatforms[index]),
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
              ]);
            })
      ],
    );
  }
}