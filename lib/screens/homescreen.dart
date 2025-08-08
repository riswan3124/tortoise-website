import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:tortoise_techno/widgets/footer.dart';
import 'package:tortoise_techno/widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

            return Stack(
              children: [
                Positioned.fill(
                  top: isMobile ? 70 : 80,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: isMobile ? 20 : 40),
                        _buildHeroSection(context, isMobile),
                        const SizedBox(height: 80),
                        /* _buildCategoriesSection(isMobile), // 👈 Moved this up
                        const SizedBox(height: 80),*/
                        _buildBrandsSection(isMobile), // 👈 Moved this down
                        const SizedBox(height: 80),
                        Footer(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Navbar(
                      onBrandSelected: (selectedBrand) {
                        Navigator.pushNamed(
                          context,
                          '/products',
                          arguments: {
                            'filterType': 'brand',
                            'value': selectedBrand,
                          },
                        );
                      },
                      onProductSelected: (selectedCategory) {
                        Navigator.pushNamed(
                          context,
                          '/products',
                          arguments: {
                            'filterType': 'category',
                            'value': selectedCategory,
                          },
                        );
                      },
                      brands: const [
                        'Samsung',
                        'Sony',
                        'Jabra',
                        'LG',
                        'PeopleLink',
                        'Vu',
                        'AVer',
                      ],
                      products: const [
                        'TVs',
                        'Speakers',
                        'Cameras',
                        'Microphones',
                        'Racks',
                      ],
                      brand: [],
                      product: [],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 100,
        horizontal: isMobile ? 20 : 100,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeroImage(isMobile),
                const SizedBox(height: 30),
                _buildHeroText(isMobile),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildHeroText(isMobile)),
                const SizedBox(width: 40),
                Expanded(child: _buildHeroImage(isMobile)),
              ],
            ),
    );
  }

  Widget _buildHeroImage(bool isMobile) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/images/background image.png',
        fit: BoxFit.contain,
        height: isMobile ? 240 : 400,
      ),
    );
  }

  Widget _buildHeroText(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          "Tortoise Techno Solutions",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 24 : 48,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "We specialize in providing premium video conferencing devices tailored to modern communication needs. From boardrooms to home offices, our range of cameras, microphones, speakers, and displays ensure stunning clarity and seamless collaboration.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.urbanist(
            fontSize: isMobile ? 14 : 18,
            color: Colors.black,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 34,
              vertical: isMobile ? 12 : 18,
            ),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
          ),
          child: Text(
            "About Us",
            style: GoogleFonts.urbanist(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }

  /*Widget _buildCategoriesSection(bool isMobile) {
    final categories = [
      {'label': 'TVs', 'icon': 'assets/images/icons/television.png'},
      {'label': 'Speakers', 'icon': 'assets/images/icons/speaker.png'},
      {'label': 'Cameras', 'icon': 'assets/images/icons/video-camera.png'},
      {'label': 'Microphones', 'icon': 'assets/images/icons/microphone.png'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Categories",
            style: GoogleFonts.dmSans(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 60,
            runSpacing: 20,
            children: categories.map((category) {
              return InkWell(
                onTap: () {
                  // Navigate to category screen
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isMobile ? 130 : 180,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        category['icon']!,
                        height: isMobile ? 40 : 60,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        category['label']!,
                        style: GoogleFonts.dmSans(
                          fontSize: isMobile ? 14 : 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }*/

  Widget _buildBrandsSection(bool isMobile) {
    final brandLogos = [
      'assets/images/banners/LG-banner.jpg',
      'assets/images/banners/PeopleLink-banner.webp',
      'assets/images/banners/samsung banner.jpeg',
      'assets/images/banners/Sony_Banner.webp',
      'assets/images/banners/Jabra_banner.png',
      'assets/images/banners/aver-banner.jpg',
      'assets/images/banners/Vu_banner.png',
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trusted Brands We Provide",
            style: GoogleFonts.dmSans(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 0.4,
              height: 100,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
            ),
            items: brandLogos.map((logo) {
              return Builder(
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(logo, height: 80, fit: BoxFit.contain),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
