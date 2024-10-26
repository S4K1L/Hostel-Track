import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackhostel/res/constant/colors.dart';

class AddHostelPage extends StatefulWidget {
  const AddHostelPage({super.key});

  @override
  _AddHostelPageState createState() => _AddHostelPageState();
}

class _AddHostelPageState extends State<AddHostelPage> {
  final TextEditingController _hostelNameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _hostelNameController.dispose();
    super.dispose();
  }

  Future<void> _saveHostel() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _firestore.collection('hostel').add({
          'hostelName': _hostelNameController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });

        Get.snackbar(
          'Success',
          'Hostel name saved successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        _hostelNameController.clear();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to save hostel name. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ADD HOSTEL',style: TextStyle(color: kWhiteColor,letterSpacing: 2),),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter the Hostel Name',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _hostelNameController,
                decoration: InputDecoration(
                  labelText: 'Hostel Name',
                  hintText: 'Enter hostel name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.home),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a hostel name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(60),
                      topLeft: Radius.circular(60),
                    ),
                    color: Colors.green,
                  ),
                  child: TextButton(
                    onPressed: _isLoading ? null : _saveHostel,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'SAVE HOSTEL',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
