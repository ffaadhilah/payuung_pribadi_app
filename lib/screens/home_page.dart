import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_app/blocs/home_bloc/home_bloc.dart';
import 'package:payuung_pribadi_app/blocs/category_bloc/category_bloc.dart';
import 'package:payuung_pribadi_app/blocs/wellness_bloc/wellness_bloc.dart';
import 'package:payuung_pribadi_app/models/product_model.dart';
import 'package:payuung_pribadi_app/models/category_model.dart';
import 'package:payuung_pribadi_app/models/wellness_model.dart';
import 'package:payuung_pribadi_app/widgets/product_widget.dart';
import 'package:payuung_pribadi_app/widgets/category_widget.dart';
import 'package:payuung_pribadi_app/widgets/wellness_widget.dart';
import 'package:payuung_pribadi_app/screens/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = false;
  double _bottomSheetHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[700],
          elevation: 0,
          title: Row(
            children: [
              Text('Selamat Sore'),
              Spacer(),
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(30),
                ),
                tabs: [
                  Tab(text: 'Payuung Pribadi'),
                  Tab(text: 'Payuung Karyawan'),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                _buildContentSection(context),
                _buildContentSection(context),
              ],
            ),
            _buildBottomSheet(),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Produk Keuangan'),
          _buildProductSection(context),
          _buildSectionTitle('Kategori Pilihan'),
          _buildCategorySection(context),
          _buildSectionTitle('Explore Wellness'),
          _buildWellnessSection(context),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: _bottomSheetHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                  _bottomSheetHeight = isExpanded ? 450.0 : 100.0;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ),
            if (isExpanded)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _buildBottomNavigationItem(Icons.home, 'Beranda', 0),
                      _buildBottomNavigationItem(Icons.search, 'Cari', 1),
                      _buildBottomNavigationItem(
                          Icons.shopping_cart, 'Keranjang', 2),
                      _buildBottomNavigationItem(
                          Icons.receipt, 'Daftar Transaksi', 3),
                      _buildBottomNavigationItem(
                          Icons.card_giftcard, 'Voucher Saya', 4),
                      _buildBottomNavigationItem(
                          Icons.location_on, 'Alamat Pengiriman', 5),
                      _buildBottomNavigationItem(
                          Icons.people, 'Daftar Teman', 6),
                    ],
                  ),
                ),
              )
            else
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBottomNavigationIcon(Icons.home, 'Beranda', 0),
                    _buildBottomNavigationIcon(Icons.search, 'Cari', 1),
                    _buildBottomNavigationIcon(
                        Icons.shopping_cart, 'Keranjang', 2),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationIcon(IconData icon, String label, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30, color: Colors.grey),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildBottomNavigationItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          _bottomSheetHeight = isExpanded ? 200.0 : 100.0;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 30, color: Colors.grey),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Text(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildProductSection(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return _buildProductGrid(state.products);
        } else if (state is HomeError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoaded) {
          return _buildCategoryGrid(state.categories);
        } else if (state is CategoryError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }

  Widget _buildWellnessSection(BuildContext context) {
    return BlocBuilder<WellnessBloc, WellnessState>(
      builder: (context, state) {
        if (state is WellnessLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is WellnessLoaded) {
          return _buildWellnessList(state.wellnessItems);
        } else if (state is WellnessError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          return ProductWidget(product: products[index]);
        },
      ),
    );
  }

  Widget _buildCategoryGrid(List<Category> categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        itemCount: categories.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          return CategoryWidget(category: categories[index]);
        },
      ),
    );
  }

  Widget _buildWellnessList(List<Wellness> wellnessItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: wellnessItems.map((wellness) {
          return WellnessWidget(wellness: wellness);
        }).toList(),
      ),
    );
  }
}
