import 'package:flutter/material.dart';
import 'package:weather/core/theme/app_pallete.dart';
import 'package:weather/features/manage_cities/presentation/pages/search.dart';

class ManageCity extends StatelessWidget {
  const ManageCity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            showDragHandle: true,
            context: context,
            builder: (context) {
              return const SearchCity();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Manage cities"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 0,
        itemBuilder: (context, index) {
          TextStyle? style = Theme.of(context).textTheme.titleLarge;
          return Card(
            color: AppPallete.cardColor,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              onTap: () {},
              title: Text("cityName", style: style),
              subtitle: Text("22°C", style: style),
              trailing: Image.asset("assets/weather images/clouds.png"),
            ),
          );
        },
      ),
    );
  }
}
