import 'package:attendence_admin_app/data/initdata.dart';
import 'package:attendence_admin_app/models/usermodel.dart';
import 'package:attendence_admin_app/service/getKey.dart';
import 'package:attendence_admin_app/services/firebase/fb_handeler.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/components/rounded_button.dart';
import '/components/rounded_input_field.dart';
import '/constants.dart';
import '/provider/registration.dart';
import '/provider/registration_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:random_password_generator/random_password_generator.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({Key? key}) : super(key: key);

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final regNumController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumController = TextEditingController();
  final classController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    regNumController.dispose();
    addressController.dispose();
    phoneNumController.dispose();
    classController.dispose();
    super.dispose();
  }

  var _studentRegistation = Register(
    id: null,
    name: '',
    email: '',
    indexNum: '',
    address: '',
    phoneNum: '',
  );

  var newPassword = RandomPasswordGenerator().randomPassword(
      letters: true,
      numbers: true,
      uppercase: true,
      specialChar: true,
      passwordLength: 6);

  Future<void> _saveForm(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();
    final vtext = KeyStore.genaratertext();
    final key = KeyStore.genaratekeycode();
    final usermodel = UserModel(
        key: key,
        name: _studentRegistation.name!,
        email: _studentRegistation.email!,
        phone: _studentRegistation.phoneNum!,
        indexno: _studentRegistation.indexNum!,
        date: DateTime.now().toIso8601String(),
        verifyText: vtext);
    await Provider.of<Registrations>(context, listen: false)
        .registerStudent(_studentRegistation);
    await FbHandeler.createDocManual(
        usermodel.toMap(), CollectionPath.userpath, usermodel.email);
    await Provider.of<Registrations>(context, listen: false)
        .signUp(emailController.text.trim(), newPassword);
    await Provider.of<Registrations>(context, listen: false).sendEmail(
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        password: newPassword);

    setState(() {
      _isLoading = false;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Registration Successful'),
              content: Text(
                  'Confermation email was sent to ' + emailController.text),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(this.context).pop();
                    },
                    child: const Text('Ok'))
              ],
            ));

    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register a student'),
        backgroundColor: kPrimaryColor,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RoundedInputField(
                          controller: nameController,
                          hintText: 'Full Name',
                          onSaved: (value) {
                            _studentRegistation = Register(
                              id: _studentRegistation.id,
                              name: value,
                              email: _studentRegistation.email,
                              indexNum: _studentRegistation.indexNum,
                              className: _studentRegistation.className,
                              address: _studentRegistation.address,
                              phoneNum: _studentRegistation.phoneNum,
                            );
                          },
                        ),
                        RoundedInputField(
                          controller: emailController,
                          hintText: 'Email',
                          icon: Icons.email,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                          onSaved: (value) {
                            _studentRegistation = Register(
                              id: _studentRegistation.id,
                              name: _studentRegistation.name,
                              email: value,
                              indexNum: _studentRegistation.indexNum,
                              className: _studentRegistation.className,
                              address: _studentRegistation.address,
                              phoneNum: _studentRegistation.phoneNum,
                            );
                          },
                        ),
                        RoundedInputField(
                          controller: regNumController,
                          hintText: 'Index number',
                          icon: Icons.assignment_ind,
                          onSaved: (value) {
                            _studentRegistation = Register(
                              id: _studentRegistation.id,
                              name: _studentRegistation.name,
                              email: _studentRegistation.email,
                              indexNum: value,
                              className: _studentRegistation.className,
                              address: _studentRegistation.address,
                              phoneNum: _studentRegistation.phoneNum,
                            );
                          },
                        ),
                        RoundedInputField(
                          controller: classController,
                          hintText: 'Class',
                          icon: Icons.class_,
                          onSaved: (value) {
                            _studentRegistation = Register(
                              id: _studentRegistation.id,
                              name: _studentRegistation.name,
                              email: _studentRegistation.email,
                              indexNum: _studentRegistation.indexNum,
                              className: value,
                              address: _studentRegistation.address,
                              phoneNum: _studentRegistation.phoneNum,
                            );
                          },
                        ),
                        RoundedInputField(
                          controller: addressController,
                          hintText: 'Address',
                          icon: Icons.home,
                          onSaved: (value) {
                            _studentRegistation = Register(
                              id: _studentRegistation.id,
                              name: _studentRegistation.name,
                              email: _studentRegistation.email,
                              indexNum: _studentRegistation.indexNum,
                              className: _studentRegistation.className,
                              address: value,
                              phoneNum: _studentRegistation.phoneNum,
                            );
                          },
                        ),
                        RoundedInputField(
                          controller: phoneNumController,
                          hintText: 'Phone number',
                          icon: Icons.phone_android,
                          onSaved: (value) {
                            _studentRegistation = Register(
                              id: _studentRegistation.id,
                              name: _studentRegistation.name,
                              email: _studentRegistation.email,
                              indexNum: _studentRegistation.indexNum,
                              className: _studentRegistation.className,
                              address: _studentRegistation.address,
                              phoneNum: value,
                            );
                          },
                        ),
                        RoundedButton(
                          text: const Text('Regester'),
                          press: () {
                            _saveForm(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  // Future register() async {
  //   final isValid = _formKey.currentState!.validate();
  //   if (!isValid) return;
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => Center(
  //             child: CircularProgressIndicator(),
  //           ));
  //   try {
  //     Provider.of<Registrations>(context, listen: false)
  //         .registerStudent(_studentRegistation);
  //   } catch (e) {}
  //   // try {
  //   //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //   //       email: emailController.text.trim(),
  //   //       password: passwordController.text.trim());
  //   // } on FirebaseException catch (e) {
  //   //   Utils.showSnackBAr(e.message);
  //   // }
  //   // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  // }
}
