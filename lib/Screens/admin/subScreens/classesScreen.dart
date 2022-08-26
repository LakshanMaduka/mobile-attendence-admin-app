import 'package:attendence_admin_app/constants.dart';
import 'package:attendence_admin_app/provider/className.dart';
import 'package:attendence_admin_app/provider/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _saveForm(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();
    await Provider.of<Registrations>(context, listen: false)
        .addClass(_studentRegistation);
    setState(() {
      _isLoading = false;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Class is added Successfully'),
            ));
  }

  var _studentRegistation = Class(
    className: '',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Classes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Your Classes",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 300,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(15)),
            ),
            ElevatedButton.icon(
                onPressed: () => showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) => buildSheet()),
                style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                icon: const Icon(Icons.add),
                label: Text('Add a Class')),
          ],
        ),
      ),
    );
  }

  Widget buildSheet() => Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Enter Class Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextFormField(
                          controller: controller,
                          onSaved: (value) {
                            _studentRegistation = Class(className: value);
                          },
                          autofocus: true,
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {
                            _saveForm(context);
                          },
                          child: Text('Add'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 400,
                        )
                      ],
                    ),
                  ),
                ),
              ),
      );
}
