import 'package:flutter/material.dart';
import '../screens/saving_plan_screen.dart'; // to access currentSavingPlanData

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<HomeScreen> {
  HomePage({dynamic key});

  Widget _buildDashboard() {
    if (currentSavingPlanData == null) {
      return const Center(child: Text('No saving plan set up yet.'));
    }
    final plan = currentSavingPlanData!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Saving Plan Overview',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          child: ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Remaining Balance'),
            subtitle: Text('\$${plan.remainingBalance.toStringAsFixed(2)}'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.monetization_on),
            title: const Text('Accumulated Interest'),
            subtitle: Text('\$${plan.accumulatedInterest.toStringAsFixed(2)}'),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Usage Withdrawals:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ...plan.usageEntries.map((usage) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.money_off),
              title: Text(usage.label),
              subtitle:
                  Text('Total Withdrawn: \$${usage.amount.toStringAsFixed(2)}'),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context, String label, String route) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(label),
    );
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bank Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () => Navigator.pushNamed(context, '/chat'),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/avatar'),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage:
                    const AssetImage('assets/avatars/avatar2.png'),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: _buildDashboard(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_buildMenuButton(context, 'Link PNC Account', '/pnc')],
            ),
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(Icons.home,
                  color: Color.fromRGBO(0, 118, 81, 0.667),)),
                BottomNavigationBarItem(
                  label: "My Savings",
                  icon: Icon(Icons.wallet,
                  color: Color.fromRGBO(0, 118, 81, 0.667),)),
              ],
              currentIndex: 0,
              onTap: (int index) {
                if (index == 0) {
                  Navigator.pushNamed(context, '/HomeScreen');
                }
                if (index == 1) {
                  Navigator.pushNamed(context, '/savingPlan');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
