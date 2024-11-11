import 'package:flutter/material.dart';
import 'package:deliverit/Widgets/search_view/search_bar.dart';
import 'package:deliverit/Widgets/search_view/filter_widget.dart';
import 'package:deliverit/Views/filter_selection_view.dart';
import 'package:deliverit/Widgets/search_view/shop_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliverit/Views/shop_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final List<String> _selectedFilters = [];
  String _searchQuery = '';
  final FocusNode _searchFocusNode = FocusNode(); // Added FocusNode

  @override
  void dispose() {
    // Safely dispose of the FocusNode
    if (_searchFocusNode.hasFocus) {
      _searchFocusNode.unfocus();
    }
    _searchFocusNode.dispose(); // Dispose the FocusNode to avoid memory leaks
    super.dispose();
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
  }

  void _navigateToFilterSelection() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const FilterSelectionView()),
    ).then((_) {
      setState(() {}); // Refresh after returning to update filters
    });
  }

  List<Shop> _filterShops() {
    List<Shop> filteredShops = shops;

    if (_selectedFilters.contains('Category 1')) {
      filteredShops = filteredShops.where((shop) => shop.category == 'Mediterranean').toList();
    }
    if (_selectedFilters.contains('Category 2')) {
      filteredShops = filteredShops.where((shop) => shop.category == 'Eastern European').toList();
    }
    if (_selectedFilters.contains('Category 3')) {
      filteredShops = filteredShops.where((shop) => shop.category == 'Latin American').toList();
    }

    if (_searchQuery.isNotEmpty) {
      filteredShops = filteredShops.where((shop) => shop.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    return filteredShops;
  }

  void _navigateToShopDetail(Shop shop) {
    // Unfocus the search bar before navigating
    _searchFocusNode.unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShopDetailView(
          name: shop.name,
          imagePath: shop.imagePath,
          deliveryPrice: shop.deliveryPrice,
          deliveryTimeMin: shop.deliveryTimeMin,
          deliveryTimeMax: shop.deliveryTimeMax,
          discount: shop.discount,
          rating: shop.rating,
        ),
      ),
    ).then((_) {
      // Ensure keyboard remains closed when coming back to SearchView
      _searchFocusNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredShops = _filterShops();

    return Scaffold(
      backgroundColor: const Color(0xFF292726),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 70),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: CustomSearchBar(
              focusNode: _searchFocusNode, // Pass the FocusNode to the search bar
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),

          // Filters Section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _navigateToFilterSelection,
                    child: FilterWidget(
                      icon: Icons.filter_list,
                      isSelected: false,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _toggleFilter('Category 1'),
                    child: FilterWidget(
                      text: 'Mediterranean',
                      isSelected: _selectedFilters.contains('Category 1'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _toggleFilter('Category 2'),
                    child: FilterWidget(
                      text: 'Eastern European',
                      isSelected: _selectedFilters.contains('Category 2'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _toggleFilter('Category 3'),
                    child: FilterWidget(
                      text: 'Latin American',
                      isSelected: _selectedFilters.contains('Category 3'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Shop List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              itemCount: filteredShops.length,
              itemBuilder: (context, index) {
                final shop = filteredShops[index];
                return GestureDetector(
                  onTap: () => _navigateToShopDetail(shop),
                  child: Container(
                    margin: const EdgeInsets.only(top: 0, bottom: 20, left: 22, right: 22),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    shop.imagePath,
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (shop.showDiscountBadge())
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xCC6AC092),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Up to ${shop.discount}% off',
                                        style: GoogleFonts.poppins(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: shop.rating >= 4.5
                                          ? const Color(0xCCFFDB67)
                                          : Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          shop.rating >= 4.5 ? Icons.star_border : Icons.star,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: 0),
                                        Text(
                                          '${shop.rating}',
                                          style: GoogleFonts.poppins(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              shop.name,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 16.0, color: Colors.grey),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${shop.deliveryTimeMin}-${shop.deliveryTimeMax} min',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
