import 'dart:developer';

import 'package:attendence_admin_app/provider/className.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './registration.dart';
import 'dart:convert';

class Registrations with ChangeNotifier {
  // final url = Uri.parse(
  //     "https://attendence-app2-default-rtdb.firebaseio.com/products.json");
  //     http.post(url,)

  List<Register> _dataList = [];
  List<Register> get datalist {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._dataList];
  }

  List<Class> _classList = [];
  List<Class> get classList {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._classList];
  }

  Future<http.Response> registerStudent(Register register) async {
    try {
      return http.post(
        Uri.parse(
            'https://attendence-app2-default-rtdb.firebaseio.com/Registration.json'),
        body: jsonEncode(<String, String>{
          'name': register.name!,
          'email': register.email!,
          'indexNum': register.indexNum!,
          'className': register.className!,
          'address': register.address!,
          'phoneNum': register.phoneNum!
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<http.Response> addClass(Class className) async {
    try {
      return http.post(
        Uri.parse(
            'https://attendence-app2-default-rtdb.firebaseio.com/Classes.json'),
        body: jsonEncode(<String, String>{'className': className.className!}),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }
  // http.post(url, body: json.encode({
  //   'title': product.title,
  //   'description': product.description,
  //   'imageUrl': product.imageUrl,
  //   'price': product.price,
  //   'isFavorite': product.isFavorite,
  // }),);

  Future signUp(String? email, String? password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> sendEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    final serviceId = 'service_s1dsu73';
    final templateId = 'template_sf3rfno';
    final userId = 'XzbSf81WE_qXWmVtB';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final reponse = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'to_email': email,
            'password': password,
          }
        }));
  }

  Future<void> fetchRegistrations() async {
    final url = Uri.parse(
        'https://attendence-app2-default-rtdb.firebaseio.com/Registration.json');
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Register> loadedRegistrations = [];
      extractedData.forEach((regId, regData) {
        loadedRegistrations.add(Register(
            name: regData['name'],
            email: regData['email'],
            indexNum: regData['indexNum'],
            address: regData['address'],
            className: regData['className'],
            phoneNum: regData['phoneNum']));
      });
      _dataList = loadedRegistrations;
      notifyListeners();
    } catch (e) {}
  }
}
