import 'package:flutter/material.dart';
import 'package:tortoise_techno/service/firestore_service.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final FirestoreService firestoreService = FirestoreService();
  List<Product> products = [];
  String selectedFilter = 'All';
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null && args.containsKey('filterType')) {
      final filterType = args['filterType'];
      final value = args['value'];

      if (filterType == 'brand') {
        filterByBrand(value);
      } else if (filterType == 'category') {
        filterByCategory(value);
      }
    } else {
      fetchAllProducts();
    }
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void fetchAllProducts() async {
    setLoading(true);
    final data = await firestoreService.getAllProducts();
    setState(() {
      products = data;
      selectedFilter = 'All';
      isLoading = false;
    });
  }

  void filterByCategory(String category) async {
    setLoading(true);
    final data = await firestoreService.getProductsByCategory(category);
    setState(() {
      products = data;
      selectedFilter = category;
      isLoading = false;
    });
  }

  void filterByBrand(String brand) async {
    setLoading(true);
    final data = await firestoreService.getProductsByBrand(brand);
    setState(() {
      products = data;
      selectedFilter = brand;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Our Products"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildFilterBar(),
          const SizedBox(height: 10),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = constraints.maxWidth > 900
                          ? 4
                          : constraints.maxWidth > 600
                          ? 3
                          : 2;

                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          return ProductCard(product: products[index]);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        _buildFilterChip("All", selectedFilter == 'All', fetchAllProducts),
        _buildFilterChip(
          "Speakers",
          selectedFilter == 'Speakers',
          () => filterByCategory("Speakers"),
        ),
        _buildFilterChip(
          "Cameras",
          selectedFilter == 'Cameras',
          () => filterByCategory("Cameras"),
        ),
        _buildFilterChip(
          "Microphones",
          selectedFilter == 'Microphones',
          () => filterByBrand("Microphones"),
        ),
        _buildFilterChip(
          "TVs",
          selectedFilter == 'TVs',
          () => filterByBrand("TVs"),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool selected, VoidCallback onTap) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: Colors.orange.shade300,
      showCheckmark: false,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: selected ? Colors.orange : Colors.grey,
        width: selected ? 2 : 1,
      ),
      labelStyle: TextStyle(
        color: selected ? Colors.black : Colors.grey[800],
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
