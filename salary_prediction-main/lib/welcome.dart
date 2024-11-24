import 'package:flutter/material.dart';
import 'input.dart';
class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 0),
                  Center(
                    child: SizedBox(
                      height: 220,
                      width: 400,
                      child: Image.asset('assets/illustration.jpg'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Welcome to Salary Predictor',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Discover how much you could earn in your desired field. Get quick and accurate insights into your potential salary.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    children: [
                      Expanded(
                        child: InfoCard(
                          icon: Icons.trending_up,
                          title: 'Insights',
                          description:
                              'See data-driven salary estimates tailored for you.',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: InfoCard(
                          icon: Icons.compare,
                          title: 'Comparison',
                          description:
                              'Compare salaries across industries and roles.',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const InfoCard(
                    icon: Icons.analytics,
                    title: 'Market Trends',
                    description:
                        'Stay updated on the latest trends affecting salaries.',
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to InputPredictionForm
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InputPredictionForm()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        backgroundColor:
                            Colors.blue, // Set button background color to blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Start Prediction',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white, // Set font color to white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 36,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
