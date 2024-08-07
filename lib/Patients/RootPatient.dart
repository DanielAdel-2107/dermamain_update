import 'package:derma/Doctors/MedicationPage.dart';
import 'package:derma/Patients/HomePatient.dart';
import 'package:derma/Patients/LoginPatient.dart';
import 'package:derma/Patients/MedicationPatient.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Both/ScanPage.dart';
import '../Massages.dart';
import 'favourite.dart';

class RootPatient extends StatefulWidget {
  const RootPatient({Key? key}) : super(key: key);

  @override
  State<RootPatient> createState() => _RootPatientState();
}

class _RootPatientState extends State<RootPatient> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String name = "";
  void getInformation() async {
    try {
      Map<String, dynamic>? patient =
          await Local(FlutterSecureStorage()).getProfileDataPatient();
      name = patient["name"];
      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: _advancedDrawerController,
      backdrop: _buildBackdrop(),
      childDecoration: _buildChildDecoration(),
      drawer: _buildDrawer(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildPageView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBackdrop() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF454571),
            const Color(0xFF9F73AB).withOpacity(0.2)
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildChildDecoration() {
    return BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 0.0,
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu_outlined),
        iconSize: 27,
        color: const Color(0xFF454571),
        onPressed: () {
          _advancedDrawerController.showDrawer();
        },
      ),
      toolbarHeight: 35,
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      children: <Widget>[
        HomePatient(),
        FavouritePage(),
        const ScanPage(),
        MedicationPage(),
        MassagesPage(),
      ],
    );
  }

  CurvedNavigationBar _buildBottomNavigationBar() {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: const Color(0xFF454571),
      color: Colors.white,
      animationDuration: const Duration(milliseconds: 300),
      index: _selectedIndex,
      height: 70,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });
      },
      items: <Widget>[
        _buildIcon(Icons.home_outlined, 'Home'.tr(), 0),
        _buildIcon(Icons.favorite_border_rounded, 'Favorites'.tr(), 1),
        _buildIcon(Icons.document_scanner_outlined, 'Scanner'.tr(), 2),
        _buildIcon(Icons.medication_liquid_sharp, 'Medication'.tr(), 3),
        _buildIcon(Icons.message_outlined, 'Chats'.tr(), 4),
      ],
    );
  }

  Widget _buildIcon(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 35, // Ensuring same height and width
                height: 35,
                decoration: BoxDecoration(
                  color: _selectedIndex == index
                      ? const Color(0xFF454571)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Center(
                  child: Icon(
                    icon,
                    size: 28,
                    color: _selectedIndex == index ? Colors.white : Colors.grey,
                    semanticLabel: 'Icon $index',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 0.25),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _selectedIndex == index ? 0.0 : 1.0,
            child: Text(
              label,
              style: TextStyle(
                color:
                    _selectedIndex == index ? Colors.transparent : Colors.grey,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildUserHeader(),
              _buildDrawerItem(Icons.home_outlined, 'Home'.tr(), () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const RootPatient()));
              }),
              _buildDrawerItem(
                  Icons.medication_liquid_sharp, 'Medical history'.tr(), () {}),
              _buildDrawerItem(
                  Icons.notification_add_outlined, 'Notifications'.tr(), () {}),
              _buildDrawerItem(Icons.language_rounded, 'Language'.tr(), () {}),
              _buildDrawerItem(Icons.settings, 'Settings'.tr(), () {}),
              _buildDrawerItem(Icons.help_outline_outlined, 'Help'.tr(), () {}),
              _buildDrawerItem(Icons.logout, 'Log out'.tr(), () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginPatient()));
              }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 24.0, bottom: 64.0),
      child: Row(
        children: [
          Container(
            width: 128.0,
            height: 128.0,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              'assets/images/doctor.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                name, // 'Dr/Seif Ali',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'poe',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label, Function()? onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        label,
        style: const TextStyle(fontFamily: 'poe'),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
    );
  }
}
