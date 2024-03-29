import 'package:flipgrid/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

class ServiceClass {
  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi.json');
    String contractAddress = contractAddress1;
    final contract = DeployedContract(
        ContractAbi.fromJson(abi, 'FungibleToken'),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<String> _callFunction(String functionName, List<dynamic> args,
      Web3Client ethClient, String privateKey) async {
    EthPrivateKey credential = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(
        credential,
        Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args),
        chainId: null,
        fetchChainIdFromNetworkId: true);
    return result;
  }

  Future<String> addCustomer(String name, String email, String password,
      String customerAddress, Web3Client ethClient) async {
    print(name + email + password + customerAddress);
    var response = await _callFunction(
        'addCustomer',
        [name, email, password, EthereumAddress.fromHex(customerAddress)],
        ethClient,
        owner_private_key);
    print('Function addCustomer Called Successfully');
    return response;
  }

  Future<List<dynamic>> _ask(
      String functionName, List<dynamic> args, Web3Client ethClient) async {
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<List<dynamic>> getUserData(String email, Web3Client ethClient) async {
    var response = await _ask('getUserData', [email], ethClient);
    print('Function getUserData Called Successfully');
    print("=>${response[0]}");
    return response;
  }

  Future<List<dynamic>> getBrandAddress(String email,Web3Client ethClient) async{
    var response=await _ask('getBrandAddress',[email],ethClient);
    print('Function getBrandAddress Called Successfully');
    print("=>${response[0]}");
    return response;
  }

  Future<List<dynamic>> isCustomerMyLoyalCustomer(String brandAddress,String customerAddress,Web3Client ethClient) async{
    var response=await _ask('isCustomerMyLoyalCustomer',[EthereumAddress.fromHex(brandAddress),EthereumAddress.fromHex(customerAddress)],ethClient);
    print('Function isCustomerMyLoyalCustomer Called Successfully');
    print("=>${response[0]}");
    return response;
  }

  Future<String> mintDailyCheckInLoyaltyPoints(
      String customerAddress, Web3Client ethClient) async {
    var response = await _callFunction(
        'mintDailyCheckInLoyaltyPoints',
        [EthereumAddress.fromHex(customerAddress)],
        ethClient,
        owner_private_key);
    print('Function mintDailyCheckInLoyaltyPoints Called Successfully');
    return response;
  }

  Future<String> mintLoyaltyPoints(
      String customerAddress, BigInt points, Web3Client ethClient) async {
    var response = await _callFunction(
        'mintLoyaltyPoints',
        [EthereumAddress.fromHex(customerAddress), points],
        ethClient,
        owner_private_key);
    print('Function mintLoyaltyPoints Called Successfully');
    return response;
  }

  Future<String> makeCustomerLoyal(
      String customerAddress, Web3Client ethClient) async {
    var response = await _callFunction(
        'makeCustomerLoyal',
        [EthereumAddress.fromHex(customerAddress)],
        ethClient,
        owner_private_key);
    print('Function makeCustomerLoyal Called Successfully');
    return response;
  }

  Future<String> transferToMyFriend(String sender,
      String customerAddress, BigInt points, Web3Client ethClient) async {
    var response = await _callFunction(
        'transferToMyFriend',
        [EthereumAddress.fromHex(sender),EthereumAddress.fromHex(customerAddress), points],
        ethClient,
        owner_private_key);
    print('Function transferToMyFriend Called Successfully');
    return response;
  }

  Future<String> buyUsingFungibleToken(String brandAddress,
      String customerAddress, BigInt cost, Web3Client ethClient) async {
    var response = await _callFunction(
        'buyUsingFungibleToken',
        [
          EthereumAddress.fromHex(customerAddress),
          EthereumAddress.fromHex(brandAddress),
          cost
        ],
        ethClient,
        owner_private_key);
    print('Function buyUsingFungibleToken Called Successfully');
    return response;
  }

  Future<String> updateMoneySpendOnBrand(String brandAddress,String customerAddress,BigInt money,Web3Client ethClient) async{
    var response=await _callFunction('updateMoneySpendOnBrand',[EthereumAddress.fromHex(brandAddress),
      EthereumAddress.fromHex(customerAddress),
      money],ethClient,owner_private_key);
    print('Function updateMoneySpendOnBrand Called Successfully');
    return response;
  }

  Future<String> decayTokens(String customerAddress,BigInt points,Web3Client ethClient) async{
    var response=await _callFunction('decayTokens',[EthereumAddress.fromHex(customerAddress),
      points],ethClient,owner_private_key);
    print('Function decayTokens Called Successfully');
    return response;
  }

}
