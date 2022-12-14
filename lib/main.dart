import 'package:flutter/material.dart';
import 'package:network_request_two/constants.dart';
import 'package:network_request_two/data_service.dart';
import 'package:network_request_two/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customMaterialColor(const Color(0xff0a192f)),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0x000a192f),
        ),
      ),
      home: const MyHomePage(title: 'Network request example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_response != null)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(_response!.iconUrl),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Text(
                            '${_response!.tempInfo.temperature}°',
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text('${_response?.weatherInfo.description}'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: SizedBox(
                width: 150,
                child: TextField(
                    controller: _cityTextController,
                    decoration: const InputDecoration(labelText: 'City'),
                    textAlign: TextAlign.center),
              ),
            ),
            ElevatedButton(onPressed: _search, child: const Text('Search')),
          ],
        ),
      ),
    );
  }

  _search() async {
    final weatherResponse = await _dataService.getWeather((_cityTextController.text));
    setState(() => _response = weatherResponse);
  }
}
