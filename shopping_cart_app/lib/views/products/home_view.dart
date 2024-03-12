import 'package:flutter/material.dart';
import 'package:shopping_cart_app/service/api/app_user_service.dart';
import 'package:shopping_cart_app/views/products/shopping_view.dart';
import '../../service/auth/auth_service.dart';
import '../../utils/constants.dart';
import '../../utils/dialogs/logout_dialog.dart';
import '../../utils/enums.dart';
import 'cart_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  late String _email;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _checkUser();
  }

  void _checkUser() async {
    final user = AuthService.firebase().currentUser;
    if (user != null) {
      setState(() {
        _email = user.email;
      });

      final response = await AppUserService.checkUserOnDB(_email);

      if (response.statusCode == 200) {
        //proceed with app
        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to check user');
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      ShoppingView(email: _email),
      CartView(email: _email),
    ];

    return _isLoading
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Shopping App'),
              actions: [
                PopupMenuButton<MenuAction>(
                  onSelected: (value) async {
                    switch (value) {
                      case MenuAction.logout:
                        final shouldLogout = await showLogOutDialog(context);
                        if (shouldLogout) {
                          await AuthService.firebase().logOut();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute,
                            (_) => false,
                          );
                        }
                    }
                  },
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem<MenuAction>(
                        value: MenuAction.logout,
                        child: Text('Log out'),
                      ),
                    ];
                  },
                ),
              ],
            ),
            body: widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'Shop',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            ),
          );
  }
}
