import 'package:flutter/foundation.dart';

class Register with ChangeNotifier {
  final String? id;
  final String? name;
  final String? email;

  final String? indexNum;
  final String? address;
  final String? className;
  final String? phoneNum;

  Register({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.indexNum,
    @required this.address,
    @required this.className,
    @required this.phoneNum,
  });
}
