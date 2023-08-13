import 'package:flipgrid/main.dart';
import 'package:flipgrid/models/test_models.dart';
import 'package:flipgrid/product_list_view.dart';
import 'package:flipgrid/services/functions.dart';
import 'package:flipgrid/text_field.dart';
import 'package:flipgrid/transactions_screen.dart';
import 'package:flipgrid/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:web3dart/web3dart.dart';

import 'follow_to_earn.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key, required});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Client? client;
  Web3Client? ethClient;
  @override
  void initState() {
    client = Client();
    ethClient = Web3Client(infura_url, client!);
    super.initState();
  }

  TextEditingController transferAmountController = TextEditingController();
  TextEditingController friendEthIdController = TextEditingController();

  void showTransferDialog() async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: "Transfer To Friend",
      widget: Column(
        children: [
          TextInputWidget(
              controller: transferAmountController,
              texthint: "Enter Amount",
              textInputType: TextInputType.number),
          const SizedBox(
            height: 8,
          ),
          TextInputWidget(
              controller: friendEthIdController,
              texthint: "Enter Reciever Id",
              textInputType: TextInputType.none),
        ],
      ),
      confirmBtnText: "Send Gift!",
      onConfirmBtnTap: () {
        ServiceClass().transferToMyLoyalCustomer(friendEthIdController.text,
            int.parse(transferAmountController.text), ethClient!);
        Navigator.pop(context);
      },
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final user = ref.watch(currentUserStateProvider).getCurrentUser;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userTest.userImage),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ethereum Wallet: ${user.customerAddress}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Loyalty Points: ${user.tokens}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login Streak: ${user.loginStreak}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      showTransferDialog();
                    },
                    child: const Text("Transfer Points"),
                  ),
                  const FollowOnSocials(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ProductListView();
                        }));
                      },
                      child: const Text(
                        "Buy with points!",
                        style: TextStyle(fontSize: 16),
                      )),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const TransactionScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'Transaction History:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
