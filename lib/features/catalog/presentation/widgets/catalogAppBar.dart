import 'package:flutter/material.dart';
import 'package:mini_katalog_app/features/catalog/presentation/widgets/container.dart';

class CatalogAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final VoidCallback onCartTap;

  const CatalogAppBar({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        "Discover",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onCartTap,
          icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Find your perfect device"),
              const SizedBox(height: 10),
              container(
                icon: Icons.search,
                controller: searchController,
                hintext: "Search Products",
                onChanged: onSearchChanged,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(160); 
}