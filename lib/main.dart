import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip cost calculator',
      home: new FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  final double _formDistance = 5.0;
  String _currency = 'Dollars';
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: this._formDistance, bottom: this._formDistance),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'e.g 124',
                      labelStyle: textStyle,
                      labelText: 'Distance',
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.zero)),
                  keyboardType: TextInputType.number,
                  controller: distanceController,
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: this._formDistance, bottom: this._formDistance),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'e.g 17',
                      labelStyle: textStyle,
                      labelText: 'Distance per unit',
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.zero)),
                  keyboardType: TextInputType.number,
                  controller: avgController,
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: this._formDistance, bottom: this._formDistance),
                child: Row(children: <Widget>[
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: 'e.g 1.65',
                        labelStyle: textStyle,
                        labelText: 'Price',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                    keyboardType: TextInputType.number,
                    controller: priceController,
                  )),
                  Container(width: _formDistance * 5),
                  Expanded(
                      child: DropdownButton(
                          items: _currencies.map(
                            (String value) {
                              return DropdownMenuItem(
                                  child: new Text(value), value: value);
                            },
                          ).toList(),
                          value: _currency,
                          onChanged: (value) {
                            _onDropDownChanged(value);
                          }))
                ])),
            Row(children: [
              Expanded(
                  child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                onPressed: () {
                  setState(() {
                    this.result = _calculate();
                  });
                },
                child: Text(
                  'Submit',
                  textScaleFactor: 1.5,
                ),
              )),
              Container(width: _formDistance * 5),
              Expanded(
                  child: RaisedButton(
                color: Colors.red,
                textColor: Colors.black,
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                child: Text(
                  'Reset',
                  textScaleFactor: 1.5,
                ),
              ))
            ]),
            Text(this.result)
          ],
        ),
      ),
    );
  }

  void _onDropDownChanged(value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result = 'The total cost of your trip is ' +
        _totalCost.toStringAsFixed(2) +
        ' ' +
        _currency;
    return _result;
  }

  void _reset() {
    this.avgController.text = '';
    this.distanceController.text = '';
    this.priceController.text = '';
    setState(() {
      this._currency = 'Dollars';
      this.result = '';
    });
  }
}
