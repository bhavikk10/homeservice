import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String? _selectedCategory;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _otherCategoryController = TextEditingController();
  List<Map<String, dynamic>> _filteredCategories = [];
  bool _showSuggestions = false;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Sofa', 'icon': CupertinoIcons.rectangle_stack},
    {'name': 'Bed', 'icon': CupertinoIcons.bed_double},
    {'name': 'TV', 'icon': CupertinoIcons.device_desktop},
    {'name': 'Refrigerator', 'icon': CupertinoIcons.snow},
    {'name': 'AC', 'icon': CupertinoIcons.snow},
    {'name': 'Washing Machine', 'icon': CupertinoIcons.arrow_2_squarepath},
    {'name': 'Dining Table', 'icon': CupertinoIcons.rectangle},
    {'name': 'Chair', 'icon': CupertinoIcons.rectangle},
    {'name': 'Cabinet', 'icon': CupertinoIcons.square_stack},
    {'name': 'Microwave', 'icon': CupertinoIcons.device_desktop},
    {'name': 'Oven', 'icon': CupertinoIcons.flame_fill},
    {'name': 'Other', 'icon': CupertinoIcons.ellipsis_circle},
  ];

  @override
  void initState() {
    super.initState();
    _filteredCategories = _categories;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    _searchController.dispose();
    _otherCategoryController.dispose();
    _searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = _categories;
        _showSuggestions = false;
      } else {
        _filteredCategories = _categories
            .where((cat) => cat['name'].toString().toLowerCase().contains(query))
            .toList();
        _showSuggestions = true; // Always show when there's a query
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: Text(
          'Add a new item',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: CupertinoColors.black,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Enhanced Camera Icon Section - Full Width
              GestureDetector(
                onTap: () {
                  // Open camera
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.actionBlue.withOpacity(0.1),
                        AppColors.actionBlue.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.actionBlue.withOpacity(0.3), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.actionBlue.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.actionBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(CupertinoIcons.camera_fill, color: CupertinoColors.white, size: 40),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Tap to Capture',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.actionBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Search Bar with Suggestions Dropdown (in layout flow so it's visible)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: CupertinoTextField(
                      controller: _searchController,
                      placeholder: 'Search for item category...',
                      placeholderStyle: AppTextStyles.body.copyWith(color: AppColors.textPlaceholder),
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(CupertinoIcons.search, color: AppColors.textPlaceholder),
                      ),
                      decoration: null,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      onChanged: (value) {
                        _onSearchChanged();
                      },
                      onTap: () {
                        setState(() {
                          _filteredCategories = _searchController.text.isEmpty
                              ? _categories
                              : _categories
                                  .where((cat) => cat['name']
                                      .toString()
                                      .toLowerCase()
                                      .contains(_searchController.text.toLowerCase()))
                                  .toList();
                          _showSuggestions = true;
                        });
                      },
                    ),
                  ),
                  // Suggestions Dropdown - in flow so it pushes content down and stays visible
                  if (_showSuggestions && _filteredCategories.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 220),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredCategories.length,
                        itemBuilder: (context, index) {
                          final category = _filteredCategories[index];
                          return CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            alignment: Alignment.centerLeft,
                            onPressed: () {
                              setState(() {
                                _selectedCategory = category['name'] as String;
                                _searchController.text = category['name'] as String;
                                _showSuggestions = false;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(category['icon'] as IconData, color: AppColors.actionBlue, size: 20),
                                const SizedBox(width: 12),
                                Text(
                                  category['name'] as String,
                                  style: AppTextStyles.body,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 24),
              // Category Grid
              Text('Select Category', style: AppTextStyles.header),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 1.1,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category['name'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category['name'] as String;
                        _searchController.text = category['name'] as String;
                        _showSuggestions = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.actionBlue.withOpacity(0.1) : CupertinoColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.actionBlue : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'] as IconData,
                            color: isSelected ? AppColors.actionBlue : AppColors.textSecondary,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category['name'] as String,
                            style: AppTextStyles.subtext.copyWith(
                              color: isSelected ? AppColors.actionBlue : AppColors.textSecondary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              // Item Name Input
              Text('Item Name', style: AppTextStyles.header),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CupertinoTextField(
                  controller: _nameController,
                  placeholder: 'e.g., LG 55" Smart TV',
                  placeholderStyle: AppTextStyles.body.copyWith(color: AppColors.textPlaceholder),
                  decoration: null,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              // Conditional Field for "Other" Category
              if (_selectedCategory == 'Other') ...[
                Text('Specify Category', style: AppTextStyles.header),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CupertinoTextField(
                    controller: _otherCategoryController,
                    placeholder: 'Enter custom category name...',
                    placeholderStyle: AppTextStyles.body.copyWith(color: AppColors.textPlaceholder),
                    decoration: null,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              // Additional Details Input
              Text('Additional Details (Optional)', style: AppTextStyles.header),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.all(16),
                child: CupertinoTextField(
                  controller: _detailsController,
                  placeholder: 'Model number, purchase date, warranty info...',
                  placeholderStyle: AppTextStyles.body.copyWith(color: AppColors.textPlaceholder),
                  maxLines: 3,
                  decoration: null,
                  padding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 32),
              // Add Item Button
              AppButton(
                text: 'Add Item',
                onPressed: () {
                  if (_selectedCategory != null && _nameController.text.isNotEmpty) {
                    // Add item logic
                    Navigator.of(context).pop();
                  }
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
