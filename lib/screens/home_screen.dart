import 'package:api_test/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(controllerProvider.notifier).fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(controllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Api Testing'), backgroundColor: Colors.blue),

      body: RefreshIndicator(
        onRefresh: () => ref.read(controllerProvider.notifier).fetchData(context),
        child: Consumer(
          builder: (context, ref, _) {
            return ListView.builder(
              itemCount: controller.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(12), // Inner padding
                  // LEADING: Use a CircleAvatar for IDs to make them look like icons
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    foregroundColor: Colors.blue.shade900,
                    radius: 24,
                    child: Text(
                      '${controller[index].id ?? "?"}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
        
                  // TITLE: Handle nulls and prevent unlimited wrapping
                  title: Text(
                    controller[index].title ?? "Untitled Post", // Fix: Don't show "null" string
                    maxLines: 1, // Fix: Keep list uniform
                    overflow: TextOverflow.ellipsis, // Fix: Add "..." if too long
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1.2,
                    ),
                  ),
        
                  // SUBTITLE: Lighter text, restricted height
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      controller[index].body ?? "No content available",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[700], height: 1.3),
                    ),
                  ),
        
                  // Optional: Add a trailing arrow to indicate clickability
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
        
                  // Interaction
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Selected Post: ${controller[index].id}")));
                  },
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // ------------------------------
  // Popup Dialog Function
  // ------------------------------
  void _showAddDialog(BuildContext context) {
    final userIdController = TextEditingController();
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create New Post"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: userIdController,
                decoration: InputDecoration(
                  labelText: "User ID",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: bodyController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Body",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                final userId = int.tryParse(userIdController.text.trim());
                final title = titleController.text.trim();
                final body = bodyController.text.trim();

                if (title.isNotEmpty && body.isNotEmpty) {
                  ref.read(controllerProvider.notifier).createData(context, userId!, title, body); // <-- Your future API call

                  Navigator.pop(context);
                }
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
