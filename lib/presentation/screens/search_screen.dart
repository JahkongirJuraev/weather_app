import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  static const String routeName = '/search-city';

  final _formKey = GlobalKey<FormState>();

  String? _city;

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(_city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search a city"),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter City Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please, enter a city";
                    } else if (value.length < 3) {
                      return "Please, enter at least 3 characters";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _city = value;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => _submit(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  "GET WEATHER",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }
}
