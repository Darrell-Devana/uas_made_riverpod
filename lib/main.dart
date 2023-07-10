import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management Riverpod',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Define the ChangeNotifierProvider for the CounterProvider
final counterProvider = ChangeNotifierProvider((ref) => CounterProvider());

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtain the current value of the counter using ref.watch
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('State Management Riverpod'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Counter Value:',
                ),
                Text(
                  '${counter.counter}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                // Call the increment method of CounterProvider when the ElevatedButton is pressed
                onPressed: () => ref.read(counterProvider).increment(),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(
                      24.0), // Increase the padding for a larger button
                ),
                child: Icon(Icons.add),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                // Call the decrement method of CounterProvider when the ElevatedButton is pressed
                onPressed: () => ref.read(counterProvider).decrement(),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(
                      24.0), // Increase the padding for a larger button
                ),
                child: Icon(Icons.remove),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners(); // Notify listeners of the state change
  }

  void decrement() {
    _counter--;
    notifyListeners(); // Notify listeners of the state change
  }
}
