import 'package:essentials_exchange/providers/requestItems.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore

class AddRequestScreen extends StatefulWidget {
  static const routeName = '/add-request';

  @override
  _AddRequestScreenState createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _titleFocus = FocusNode();

  final FocusNode _descriptionFocus = FocusNode();

  String _title = '';
  String _description = '';
  File _image;
  String _uploadedURL;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future uploadFile() async {
    final FirebaseStorage storageReference =
        FirebaseStorage(storageBucket: 'gs://essentials-exchange.appspot.com');
    String fileName = Uuid().v4();
    StorageReference fileRef =
        storageReference.ref().child('images/item/' + fileName);
    StorageUploadTask uploadTask = fileRef.putFile(_image);
    StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    String fileURL = (await downloadUrl.ref.getDownloadURL());

    setState(() {
      _uploadedURL = fileURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    var requestData = Provider.of<Requests>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Request',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    focusNode: _titleFocus,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_descriptionFocus),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a title!';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      this._title = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    focusNode: _descriptionFocus,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a description!';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      this._description = value;
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RaisedButton(
                          child: Text("Select Image from Gallery"),
                          onPressed: () {
                            getImage();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        height: 240,
                        child: Center(
                          child: _image == null
                              ? Text('No image selected.')
                              : Image.file(_image),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () async {
                        _formKey.currentState.save();

                        // requestData.addItemToDatabase();

                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          await uploadFile();
                          // Process data.
                          RequestItem item = RequestItem(_title, _description,
                              "SYSTEM", _uploadedURL, DateTime.now());
                          await requestData.addItemToDatabase(item);
                          print("Upload Success");
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
