import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _foodType = 'rice'; // Default value
  XFile? _image;
  bool _isLoading = false;

  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image selected')));
    } else {
      setState(() {
        _image = image;
      });
    }
  }

  // Function to save the food item
  Future<void> _saveFoodItem() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an image')));
      return;
    }

    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty || _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var uri = Uri.parse('http://192.168.1.100:5000/api/food/addFoodItem');  // Update with the correct server address
    var request = http.MultipartRequest('POST', uri)
      ..fields['name'] = _nameController.text
      ..fields['type'] = _foodType
      ..fields['description'] = _descriptionController.text
      ..fields['amount'] = _amountController.text
      ..files.add(await http.MultipartFile.fromPath('image', _image!.path));

    var response = await request.send();

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Food item added successfully!')));
    } else {
      var responseBody = await response.stream.bytesToString();
      print('Failed to add food item: $responseBody');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add food item')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Food Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            DropdownButton<String>(
              value: _foodType,
              onChanged: (String? newValue) {
                setState(() {
                  _foodType = newValue!;
                });
              },
              items: <String>['rice', 'burger', 'dessert', 'beverages']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path), width: 100, height: 100),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _saveFoodItem,
                    child: Text('Save Food Item'),
                  ),
          ],
        ),
      ),
    );
  }
}
