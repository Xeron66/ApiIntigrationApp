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
    ref.read(controllerProvider.notifier).fetchData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(controllerProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Api Testing'), backgroundColor: Colors.blue),

      body: Consumer(
        builder: (context, ref, _) {
          return ListView.builder(
            itemCount: controller.length,
            itemBuilder: (context, index) {
              print('Screen Value ${controller[index].id}');
              return ListTile(
                leading: Text('${controller[index].userId}'),
                title: Text('${controller[index].title}'),
                subtitle: Text('${controller[index].body}'),
              );
            },
          );
        },
      ),
    );
  }
}
