
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../models/product.dart'; 
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/trending_card.dart'; 
import '../widgets/discount_card.dart'; 
import 'cart_screen.dart';
import 'favourites_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _sortOption = 'none';
  String _selectedCategory = '';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final PageController _pageController = PageController(viewportFraction: 0.8);
  Timer? _autoScrollTimer;

  Duration _flashSaleTimer = Duration(days: 1, hours: 14, minutes: 30, seconds: 31);
  Timer? _flashTimer;

  final Map<String, String> _categoryImages = {
    'electronics':
        'https://res.cloudinary.com/jerrick/image/upload/v1740658144/67c055e09f7d7d001d9227bf.jpg',
    'jewelery':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRber3pFEASJ27Vgj6BhVg3Xq7ZBvOZiUBApg&s',
    'men\'s clothing':
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80',
    'women\'s clothing':
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80',
    'All':
        'https://i.ibb.co/L84m3D3/all-products.png', 
  };

  @override
  void initState() {
    super.initState();
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.fetchProducts();
    productProvider.fetchCategories();

    _autoScrollTimer = Timer.periodic(Duration(seconds: 5), (_) => _scrollCarousel());

    _flashTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_flashSaleTimer.inSeconds > 0) {
        setState(() => _flashSaleTimer -= Duration(seconds: 1));
      } else {
        _flashTimer?.cancel();
      }
    });
  }

  void _scrollCarousel() {
    if (!_pageController.hasClients) return;
    final max = Provider.of<ProductProvider>(context, listen: false).products.length;
    final next = ((_pageController.page ?? 0).round() + 1) % max;
    _pageController.animateToPage(next,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    _flashTimer?.cancel();
    super.dispose();
  }

  void _sortProducts(List<Product> p) {
    if (_sortOption == 'price_low')
      p.sort((a, b) => a.price.compareTo(b.price));
    else if (_sortOption == 'price_high')
      p.sort((a, b) => b.price.compareTo(a.price));
    else if (_sortOption == 'rating')
      p.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');


  @override
  Widget build(BuildContext context) {
    final prodProv = Provider.of<ProductProvider>(context);
    final cartProv = Provider.of<CartProvider>(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    final all = [...prodProv.products];
    _sortProducts(all);
    final filtered = all.where((p) {
      final okSearch = p.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final okCat = _selectedCategory.isEmpty ||
          _selectedCategory == 'All' ||
          p.category.toLowerCase() == _selectedCategory.toLowerCase();
      return okSearch && okCat;
    }).toList();


    final topRated = [...all]..sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
    final trending = topRated.take(4).toList();


    final List<Product> menProducts = all.where((p) => p.category.toLowerCase() == 'men\'s clothing').toList();
    final List<Product> womenProducts = all.where((p) => p.category.toLowerCase() == 'women\'s clothing').toList();

    menProducts.sort((a, b) => b.price.compareTo(a.price));
    womenProducts.sort((a, b) => b.price.compareTo(a.price));

    final Product? highPricedMenProduct = menProducts.isNotEmpty ? menProducts.first : null;
    final Product? highPricedWomenProduct = womenProducts.isNotEmpty ? womenProducts.first : null;

    final days = _twoDigits(_flashSaleTimer.inDays);
    final hours = _twoDigits(_flashSaleTimer.inHours.remainder(24));
    final minutes = _twoDigits(_flashSaleTimer.inMinutes.remainder(60));
    final seconds = _twoDigits(_flashSaleTimer.inSeconds.remainder(60));

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, 
      appBar: AppBar(
        title: Text('Smart Shop'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: themeProv.toggleTheme,
          ),
          Stack(children: [
            IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CartScreen()))),
            if (cartProv.itemCount > 0)
              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    '${cartProv.itemCount}',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              )
          ]),
        ],
      ),
      drawer: Drawer(

        backgroundColor: theme.cardColor,
        child: Column(
          children: [
            Container(
              height: 120,
              color: theme.primaryColor,
              alignment: Alignment.center,
              child: Text('Smart Shop',
                  style: TextStyle(
                      color: theme.colorScheme.onPrimary, 
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ),
            _drawerItem(Icons.home, "Home", () => Navigator.pop(context)),
            _drawerItem(Icons.shopping_cart, "Cart", () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CartScreen()));
            }),
            _drawerItem(Icons.favorite, "Favourites", () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => FavouritesScreen()));
            }),
            _drawerItem(Icons.person, "Profile", () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ProfileScreen()));
            }),
            Divider(color: theme.dividerColor), 
            SwitchListTile(
              title: Text("Dark Mode", style: TextStyle(color: theme.textTheme.bodyLarge?.color)), 
              value: themeProv.isDarkMode,
              onChanged: (_) => themeProv.toggleTheme(),
              secondary: Icon(Icons.brightness_6, color: theme.iconTheme.color),
            ),
            Spacer(),
            Divider(color: theme.dividerColor), 
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () async {
                await Provider.of<AuthProvider>(context, listen: false)
                    .logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => LoginScreen()));
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Search
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search, color: theme.iconTheme.color), 
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                // Ensure text input and hint text colors are theme-aware
                hintStyle: TextStyle(color: theme.hintColor),
                fillColor: theme.inputDecorationTheme.fillColor, 
                filled: true,
              ),
              style: TextStyle(color: theme.textTheme.bodyLarge?.color), 
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),

          const SizedBox(height: 24), 

          Container(
            height: 200,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://media.istockphoto.com/id/1193750118/photo/beautiful-asian-woman-carrying-colorful-bags-shopping-online-with-mobile-phone.jpg?s=612x612&w=0&k=20&c=j1SpSX7c3qzBrUT5f7HRoOfxQnPxZY_c6yb3AvXA5f8=',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(
                            color: theme.splashColor, 
                            child: Center(child: Text('Image Load Error', style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.5))))), // Theme-aware text color
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.4),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          Icon(Icons.savings, color: Colors.white),
                          SizedBox(width: 8),
                          Text('Ultimate Savings',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)),
                        ]),
                        SizedBox(height: 8),
                        Text('Your Ultimate Shopping destination',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                          ),
                          child: Text('Shop Now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)), // Theme-aware text color
          ),
          Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _categoryImages.entries.map((entry) {
                final label = entry.key;
                final imageUrl = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(imageUrl),
                        backgroundColor: theme.brightness == Brightness.dark ? Colors.grey[700] : Colors.grey[200], 
                      ),
                      SizedBox(height: 6),
                      Text(label.toLowerCase().replaceAll("'", ""), style: TextStyle(fontSize: 12, color: theme.textTheme.bodyLarge?.color)), 
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 32), 
                
          Padding(
            padding:
                EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text('Shop by categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)), 
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryChip('All', 'All', theme), // Pass 'All' label as key for image lookup
                      ...prodProv.categories
                          .map((c) => _buildCategoryChip(c, c, theme))
                          .toList(),
                    ],
                  ),
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.sort, color: theme.iconTheme.color), 
                onSelected: (v) => setState(() => _sortOption = v),
                itemBuilder: (_) => [
                  PopupMenuItem(value: 'none', child: Text('Default', style: TextStyle(color: theme.textTheme.bodyLarge?.color))), 
                  PopupMenuItem(
                      value: 'price_low', child: Text('Price: Low to High', style: TextStyle(color: theme.textTheme.bodyLarge?.color))), 
                  PopupMenuItem(
                      value: 'price_high', child: Text('Price: High to Low', style: TextStyle(color: theme.textTheme.bodyLarge?.color))),
                  PopupMenuItem(
                      value: 'rating', child: Text('Top Rated', style: TextStyle(color: theme.textTheme.bodyLarge?.color))), 
                ],
              )
            ]),
          ),
          Divider(color: Colors.grey[300], thickness: 1, height: 32),

          const SizedBox(height: 32),

          Padding(
              padding: EdgeInsets.only(left: 16, bottom: 8),
              child: Text('Our Collections',
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color))), 
          SizedBox(
            height: 375, 
            child: filtered.isEmpty
                ? Center(child: Text('No products found', style: TextStyle(color: theme.textTheme.bodyLarge?.color)))
                : PageView.builder(
                    controller: _pageController,
                    itemCount: filtered.length,
                    itemBuilder: (ctx, i) {
                      final p = filtered[i];
                      final fav = prodProv.favorites.contains(p);
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: ProductCard( 
                          product: p,
                          isFavorite: fav,
                          onFavoriteToggle: () =>
                              prodProv.toggleFavorite(p),
                          onAddToCart: () =>
                              cartProv.addToCart(p),
                        ),
                      );
                    },
                  ),
          ),

          const SizedBox(height: 32), 

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              '🔥 Trending Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color), 
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox( 
              height: 200, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal, 
                itemCount: trending.length,
                itemBuilder: (ctx, i) {
                  final p = trending[i];
                  final fav = prodProv.favorites.contains(p);
                  String? trendingStatus;
                  if (i == 0) trendingStatus = 'Hot';
                  else if (i == 1) trendingStatus = 'New';
                  else if (i == 2) trendingStatus = 'Sale';

                  return TrendingCard(
                    product: p,
                    isFavorite: fav,
                    onFavoriteToggle: () => prodProv.toggleFavorite(p),
                    onAddToCart: () => cartProv.addToCart(p), 
                    statusLabel: trendingStatus, 
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 32),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              '⚡ Hot Deals', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color), 
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (highPricedMenProduct != null)
                  Expanded(
                    child: DiscountCard(product: highPricedMenProduct, discountPercentage: 0.20),
                  ),
                SizedBox(width: 12),
                if (highPricedWomenProduct != null)
                  Expanded( 
                    child: DiscountCard(product: highPricedWomenProduct, discountPercentage: 0.20),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1593640408182-31c70c8268f5?q=80&w=842&auto=format&fit=crop',
                    height: 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 280,
                      color: theme.splashColor, 
                      child: Center(
                        child: Text('Image Load Error', style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.5))),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Positioned(
                  left: 24,
                  top: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flash Sale',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '50% OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'ON ENTIRE ORDER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'LIMITED-TIME OFFER! SALE ENDS IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTimeContainer(days, 'DAYS', theme), 
                          SizedBox(width: 8),
                          _buildTimeContainer(hours, 'HRS', theme), 
                          SizedBox(width: 8),
                          _buildTimeContainer(minutes, 'MIN', theme), 
                          SizedBox(width: 8),
                          _buildTimeContainer(seconds, 'SEC', theme), 
                        ],
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Shop The Flash Sale Now',
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary, 
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          'NO, THANKS!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text("Why Smart Shop?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)), 
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _promiseBox(Icons.verified, "Good Quality", theme)), 
                SizedBox(width: 12),
                Expanded(child: _promiseBox(Icons.refresh, "Easy Returns", theme)), 
                SizedBox(width: 12),
                Expanded(child: _promiseBox(Icons.support_agent, "24/7 Support", theme)), 
              ],
            ),
          ),

          const SizedBox(height: 32)

          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark ? Colors.grey.shade800 : Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.phone_android, size: 40, color: theme.primaryColor),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Download Our App", style: TextStyle(fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)), 
                      SizedBox(height: 4),
                      Text("Shop anytime, anywhere!", style: TextStyle(color: theme.textTheme.bodyMedium?.color)), 
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: theme.colorScheme.onPrimary, 
                  ),
                  child: Text("Download"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24), 

        ]),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String t, VoidCallback h) {
    final theme = Theme.of(context);
    return ListTile(
        leading: Icon(icon, color: theme.iconTheme.color),
        title: Text(t, style: TextStyle(color: theme.textTheme.bodyLarge?.color)),
        onTap: h);
  }

  Widget _buildCategoryChip(String label, String key, ThemeData t) {

    final effectiveFilterKey = label == 'All' ? '' : key;
    final sel = _selectedCategory == effectiveFilterKey;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedCategory = effectiveFilterKey);
        Provider.of<ProductProvider>(context, listen: false).fetchProducts(effectiveFilterKey);
      },
      child: Container(
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: sel ? t.primaryColor.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
              color: sel ? t.primaryColor : t.dividerColor,
              width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(children: [
          ClipOval(
            child: Image.network(
              _categoryImages[label] ?? 'https://via.placeholder.com/100', 
              width: 36,
              height: 36,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  CircleAvatar(radius: 18, backgroundColor: t.splashColor, child: Icon(Icons.category, color: t.iconTheme.color)), 
            ),
          ),
          SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  color: sel
                      ? t.primaryColor
                      : t.textTheme.bodyLarge?.color)),
        ]),
      ),
    );
  }


  Widget _promiseBox(IconData icon, String label, ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: theme.brightness == Brightness.dark ? Colors.grey.shade800 : Colors.grey.shade200, 
          borderRadius: BorderRadius.circular(12)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30, color: theme.primaryColor),
            SizedBox(height: 8),
            Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)), 
          ]),
    );
  }


  Widget _buildTimeContainer(String value, String label, ThemeData theme) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor, 
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white, 
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
