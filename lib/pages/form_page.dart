import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v_card/models/contact_model.dart';
import 'package:v_card/provider/contact_provider.dart';
import 'package:v_card/utils/helpers.dart';

class FormPage extends StatefulWidget {
  static const String routeName = '/form';

  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final designationController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New contact'),
        actions: [
          IconButton(
            onPressed: _saveContact,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Contact Name(required)',
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This  field must not be empty';
                  }
                  if (value.length > 30) {
                    return 'Name should not be more than 30 chars long';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: mobileController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.call),
                  labelText: 'Mobile Number(required)',
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This  field must not be empty';
                  }
                  if (value.length > 20) {
                    return 'Name should not be more than 20 chars long';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email address',
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: companyController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.label),
                  labelText: 'Company Name',
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: designationController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.label),
                  labelText: 'Designation',
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.streetAddress,
                controller: addressController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_city_rounded),
                  labelText: 'Street Address',
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.url,
                controller: websiteController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.web),
                  labelText: 'Website',
                  filled: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveContact() async {
    if (formKey.currentState!.validate()) {
      final contact = ContactModel(
        name: nameController.text,
        mobile: mobileController.text,
        email: emailController.text,
        company: companyController.text,
        designation: designationController.text,
        address: addressController.text,
        website: websiteController.text,
      );
      Provider.of<ContactProvider>(context, listen: false)
      .insertContact(contact)
      .then((rowId) {
        if(rowId > 0) {
          showMsg(context, 'Saved');
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    designationController.dispose();
    companyController.dispose();
    addressController.dispose();
    websiteController.dispose();
    super.dispose();
  }
}
