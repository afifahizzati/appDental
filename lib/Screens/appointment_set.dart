import 'package:dentisttry/Comm/comHelper.dart';
import 'package:flutter/material.dart';
import 'package:dentisttry/Model/data_model.dart';
import 'package:dentisttry/Screens/appointment_view.dart';
import 'package:dentisttry/DatabaseHandler/db_service.dart';
import 'package:dentisttry/Model/form_helper.dart';

class AddEditProduct extends StatefulWidget {
  //front-end of system
  AddEditProduct({Key key, this.model, this.isEditMode = false})
      : super(key: key);
  ServiceModel model;
  bool isEditMode;

  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  ServiceModel model;
  DBService dbService;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dbService = new DBService();
    model = new ServiceModel();

    if (widget.isEditMode) {
      model = widget.model;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: Text(widget.isEditMode ? "Book your Appointment" : "Services"),
      ),
      body: new Form(
        key: globalFormKey,
        child: _formUI(),
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel("Services"),
                _productCategory(),
                FormHelper.fieldLabel("Name"),
                FormHelper.textInput(
                  context,
                  model.name,
                  (value) => {
                    this.model.name = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter Name.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Email"),
                FormHelper.textInput(
                    context,
                    model.email,
                    (value) => {
                          this.model.email = value,
                        },
                    isTextArea: true, onValidate: (value) {
                  if (!validateEmail(value)) {
                    return 'Please Enter Valid Email';
                  }

                  /*validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintName';
          }
          if (hintName == "Email" && !validateEmail(value)) {
            return 'Please Enter Valid Email';
          }
          return null;
        },**/
                  return null;
                }),
                FormHelper.fieldLabel("Contact Number"),
                FormHelper.textInput(
                  context,
                  model.phone,
                  (value) => {
                    this.model.phone = double.parse(value),
                  },
                  isNumberInput: true,
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter  your contact number.';
                    }

                    if (value.toString().isNotEmpty &&
                        double.parse(value.toString()) <= 0) {
                      return 'Please enter valid phone number.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Appointment Date"),
                FormHelper.textInput(
                  context,
                  model.date,
                  (value) => {
                    this.model.date = value,
                  },
                  onValidate: (value) {
                    return null;
                  },
                ),
                btnSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _productCategory() {
    return FutureBuilder<List<CategoryModel>>(
      future: dbService.getCategories(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CategoryModel>> categories) {
        if (categories.hasData) {
          return FormHelper.selectDropdown(
            context,
            model.categoryId,
            categories.data,
            (value) => {this.model.categoryId = int.parse(value)},
            onValidate: (value) {
              if (value == null) {
                return 'Please select services.';
              }
              return null;
            },
          );
        }

        return CircularProgressIndicator();
      },
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget btnSubmit() {
    return new Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          if (validateAndSave()) {
            print(model.toMap());
            if (widget.isEditMode) {
              dbService.updateProduct(model).then((value) {
                FormHelper.showMessage(
                  context,
                  "DENTAL CARE",
                  "Your appointment have been update!",
                  "Ok",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                );
              });
            } else {
              dbService.addProduct(model).then((value) {
                FormHelper.showMessage(
                  context,
                  "THANK YOU!",
                  "Your appointment have been set!",
                  "Ok",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                );
              });
            }
          }
        },
        child: Container(
          height: 40.0,
          margin: EdgeInsets.all(10),
          width: 100,
          color: Colors.blueAccent,
          child: Center(
            child: Text(
              "Submit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
