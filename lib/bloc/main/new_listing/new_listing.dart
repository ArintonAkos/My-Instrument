import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';

class NewListingPage extends StatefulWidget {
  const NewListingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage> {

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  String _enteredText = '';
  final titleTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final _titleAndPriceKey = GlobalKey<FormState>();
  final _descriptionKey = GlobalKey<FormState>();
  static const _instruments = [
    "Guitar",
    "Violin",
    "Piano",
    "Bass",
    "Drums",
  ];
  String _currentSelectedValue = _instruments[0];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Container(
          child: Column(
            children: [

              Expanded(
                child: Stepper(
                  type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue:  continued,
                  onStepCancel: back,

                  steps: <Step>[
                    Step(
                      title: new Text('The Title and the Price of your instrument'),
                      content: Column(
                        children: <Widget>[
                          Form(
                            key: _titleAndPriceKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                                  child: TextFormField(
                                    controller: titleTextController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        labelText: 'Title',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.withAlpha(80), width: 0),
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(8),
                                            ))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the title';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                              child: TextFormField(
                                controller: priceTextController,
                                decoration: InputDecoration(labelText: 'Price',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withAlpha(80), width: 0),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ))
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the price';
                                  }
                                  return null;
                                },
                              ),
                            ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0 ?
                      StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: new Text('The Description of your instrument'),
                      content: Form(
                        key: _descriptionKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              child: TextFormField(
                                controller: descriptionTextController,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withAlpha(80), width: 0),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      )),
                                  counterText: '${_enteredText.length.toString()} character(s)/2000',
                                  //contentPadding: EdgeInsets.all(20.0),
                                ),
                                keyboardType: TextInputType.multiline,
                                //maxLines: null,
                                maxLength: 2000,
                                //maxLengthEnforced: MaxLengthEnforcement.enforced,
                                validator: (description) {
                                  if (description == null || description.isEmpty) {
                                    return 'Please write a description';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _enteredText = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1 ?
                      StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: new Text('What kind of instrument are you selling?'),
                      content: Column(
                        children: <Widget>[
                          FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                //isEmpty: _currentSelectedValue == newValue,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _currentSelectedValue,
                                    isDense: true,
                                    onChanged: (newValue) {
                                      setState(() {
                                        if(newValue != null) {
                                          _currentSelectedValue = newValue;
                                          state.didChange(newValue);
                                        }
                                      });
                                    },
                                    items: _instruments.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      isActive:_currentStep >= 0,
                      state: _currentStep >= 2 ?
                      StepState.complete : StepState.disabled,
                    ),
                  ],
                ),
              ),

          ],
        ),
      ),
    );
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
     /* if (_firstKey.currentState!.validate()) {
        _currentStep < 2 ?
        setState(() => _currentStep += 1) : null; */
    switch (_currentStep) {
      case 0:
        if (_titleAndPriceKey.currentState!.validate()) {
          setState(() => _currentStep += 1);
        }
        break;
      case 1:
        if (_descriptionKey.currentState!.validate()) {
          setState(() => _currentStep += 1);
        }
        break;
    }

  }
  back(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleTextController.dispose();
    priceTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

}