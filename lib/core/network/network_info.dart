import 'package:meta/meta.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements INetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfo({@required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}