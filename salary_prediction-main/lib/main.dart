import 'package:flutter/material.dart';
import 'input.dart';
import 'welcome.dart';
import 'result.dart';

void main() {
  runApp(SalaryPredictionAppRoot());
}

class SalaryPredictionAppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salary Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeSection(),
        '/form': (context) => InputPredictionForm(),
        // Removed '/result' here because `ResultPage` needs data dynamically.
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/result') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ResultPage(
              predictedSalary: args['predictedSalary'],
            ),
          );
        }
        return null;
      },
    );
  }
}
