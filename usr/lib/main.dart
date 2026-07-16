import 'package:flutter/material.dart';

void main() {
  runApp(const KitchenApp());
}

class KitchenApp extends StatelessWidget {
  const KitchenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitchen by Deepu Pahadi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const KitchenDashboard(),
        '/recipes': (context) => const RecipesScreen(),
        '/inventory': (context) => const InventoryScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class KitchenDashboard extends StatelessWidget {
  const KitchenDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen by Deepu Pahadi', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 800 ? 3 : (constraints.maxWidth > 500 ? 2 : 1);
          
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Chef Deepu!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Here is your kitchen overview for today.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  GridView.count(
                    crossAxisCount: crossAxisCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _buildDashboardCard(
                        context,
                        title: 'Recipe Book',
                        icon: Icons.menu_book,
                        color: Colors.orange.shade100,
                        onTap: () => Navigator.pushNamed(context, '/recipes'),
                        description: 'Manage your signature dishes',
                      ),
                      _buildDashboardCard(
                        context,
                        title: 'Inventory',
                        icon: Icons.kitchen,
                        color: Colors.blue.shade100,
                        onTap: () => Navigator.pushNamed(context, '/inventory'),
                        description: 'Check stock and supplies',
                      ),
                      _buildDashboardCard(
                        context,
                        title: 'Daily Tasks',
                        icon: Icons.checklist,
                        color: Colors.green.shade100,
                        onTap: () {
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text('Daily Tasks coming soon!'))
                           );
                        },
                        description: 'Prep lists and cleaning',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Recent Activity',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final activities = [
                          'Updated "Pahadi Chicken" recipe',
                          'Inventory check completed',
                          'New stock of spices arrived',
                        ];
                        final times = ['2 hours ago', 'Yesterday', '2 days ago'];
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.history, size: 20),
                          ),
                          title: Text(activities[index]),
                          subtitle: Text(times[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required String description,
  }) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: color.withOpacity(0.8),
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 32, color: Colors.black87),
              ),
              const Spacer(),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipes = [
      {'name': 'Pahadi Chicken Curry', 'time': '45 mins', 'type': 'Main'},
      {'name': 'Aloo Ke Gutke', 'time': '20 mins', 'type': 'Side'},
      {'name': 'Bhatt Ki Churkani', 'time': '40 mins', 'type': 'Main'},
      {'name': 'Bal Mithai', 'time': '120 mins', 'type': 'Dessert'},
      {'name': 'Gahat Ki Dal', 'time': '50 mins', 'type': 'Main'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                child: Text(recipe['name']!.substring(0, 1)),
              ),
              title: Text(recipe['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${recipe['type']} • ${recipe['time']}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening ${recipe['name']}...'))
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add recipe coming soon!'))
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Mustard Oil', 'qty': '5 Liters', 'status': 'Good'},
      {'name': 'Jakhya (Wild Mustard)', 'qty': '200 g', 'status': 'Low'},
      {'name': 'Basmati Rice', 'qty': '25 kg', 'status': 'Good'},
      {'name': 'Garlic', 'qty': '1 kg', 'status': 'Low'},
      {'name': 'Himalayan Salt', 'qty': '3 kg', 'status': 'Good'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isLow = item['status'] == 'Low';
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Quantity: ${item['qty']}'),
              trailing: Chip(
                label: Text(item['status']!),
                backgroundColor: isLow ? Colors.red.shade100 : Colors.green.shade100,
                labelStyle: TextStyle(
                  color: isLow ? Colors.red.shade900 : Colors.green.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
