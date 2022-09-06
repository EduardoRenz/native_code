import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Executing Native Code'),
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
  int _a = 0;
  int _b = 0;
  int _sum = 0;

  Future<void> sum() async {
    const channel = MethodChannel('dudarenz.com.br/native');
    try {
      final sum = await channel.invokeMethod('sum', {'a': _a, 'b': _b});
      setState(() {
        _sum = sum;
      });
    } on PlatformException catch (e) {
      print('Erro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sum: $_sum'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: ((value) =>
                    setState(() => _a = int.tryParse(value) ?? 0)),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: ((value) =>
                    setState(() => _b = int.tryParse(value) ?? 0)),
              ),
              ElevatedButton(onPressed: () => sum(), child: const Text('Sum'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Sum',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
