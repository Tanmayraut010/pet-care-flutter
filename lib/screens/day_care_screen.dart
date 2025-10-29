import 'package:flutter/material.dart';
import '../widgets/service_tag.dart';
import '../widgets/price_row.dart';
import '../widgets/bottom_nav_bar.dart';

class DayCareScreen extends StatefulWidget {
  const DayCareScreen({super.key});

  @override
  State<DayCareScreen> createState() => _DayCareScreenState();
}

class _DayCareScreenState extends State<DayCareScreen> {
  int _currentTabIndex = 1;
  int _bottomNavIndex = 1;

  final List<String> _tabs = ['PawPrints', 'Night Stay', 'Customers'];
  
  final List<String> _services = [
    'Give Medicines',
    'Feeding',
    'Bath & Dry',
    'Out Door Walks',
    'Massage',
    'Massage',
    'bath',
    'Massage',
    'Massage',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeaderSection(),
              Expanded(
                child: _buildContentCard(),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHeaderSection() {
    return SizedBox(
      height: 280,
      child: Stack(
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/day_care_image.jpg'),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {},
              ),
              color: Colors.grey[300],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(Icons.arrow_back, () {}),
                  _buildIconButton(Icons.edit, () {}, isYellow: true),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildTabBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap, {bool isYellow = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isYellow ? const Color(0xFFFFC727) : Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isYellow ? Colors.white : Colors.black,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = index == _currentTabIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentTabIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFFC727) : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  _tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey[600],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildContentCard() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDayCareHeader(),
            const SizedBox(height: 32),
            _buildIncludedServicesSection(),
            const SizedBox(height: 32),
            _buildPricingSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCareHeader() {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFFFC727),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.medical_services_outlined,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Day Care',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Offer daytime care services for pets',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.green[400],
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildIncludedServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What\'s Included in your price?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _services.map((service) => ServiceTag(label: service)).toList(),
        ),
      ],
    );
  }

  Widget _buildPricingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What is your price per night?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        PriceRow(
          label: 'Price Per Night',
          value: '14 CHF',
          isRequired: true,
        ),
        const SizedBox(height: 16),
        PriceRow(
          label: 'Pawfront Fees & Taxes',
          value: '2 CHF',
        ),
        const SizedBox(height: 16),
        PriceRow(
          label: 'You will receive',
          value: '12 CHF',
        ),
      ],
    );
  }
}

