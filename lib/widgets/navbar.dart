import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Navbar extends StatefulWidget {
  final Function(String)? onBrandSelected;
  final Function(String)? onProductSelected;
  final List<String> brands;
  final List<String> products;

  const Navbar({
    super.key,
    this.onBrandSelected,
    this.onProductSelected,
    this.brands = const [
      'Sony',
      'Teachmind',
      'LG',
      'UV',
      'Samsung',
      'Jabra',
      'AVer',
    ],
    this.products = const ['Cameras', 'TVs', 'Speakers', 'Microphones'],
    required List<String> brand,
    required List<String> product,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 10 : 40,
            vertical: isMobile ? 10 : 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/tortoise_logo.png',
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        const Spacer(),
                        _buildContactMenu(context),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        _HoverTextButton(
                          title: "Home",
                          onTap: () => Navigator.pushNamed(context, '/'),
                        ),
                        _HoverDropdown(
                          title: "Brands",
                          items: widget.brands,
                          onSelected: widget.onBrandSelected,
                        ),
                        _HoverDropdown(
                          title: "Products",
                          items: widget.products,
                          onSelected: widget.onProductSelected,
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Image.asset(
                      'assets/images/tortoise_logo.png',
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 30),
                    _HoverTextButton(
                      title: "Home",
                      onTap: () => Navigator.pushNamed(context, '/'),
                    ),
                    const SizedBox(width: 30),
                    _HoverDropdown(
                      title: "Brands",
                      items: widget.brands,
                      onSelected: widget.onBrandSelected,
                    ),
                    const SizedBox(width: 30),
                    _HoverDropdown(
                      title: "Products",
                      items: widget.products,
                      onSelected: widget.onProductSelected,
                    ),
                    const Spacer(),
                    _buildContactMenu(context),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildContactMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        final String number = value == 'whatsapp1'
            ? '917025890891'
            : '919061101169';
        final Uri whatsappUri = Uri.parse("https://wa.me/$number");

        try {
          await launchUrl(whatsappUri, mode: LaunchMode.platformDefault);
        } catch (e) {
          debugPrint("Error launching WhatsApp: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open WhatsApp for $number')),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'whatsapp1',
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
              SizedBox(width: 8),
              Text('Whatsapp 1'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'whatsapp2',
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
              SizedBox(width: 8),
              Text('Whatsapp 2'),
            ],
          ),
        ),
      ],
      child: _HoverTextButton(
        title: "Contact",
        trailingIcon: const Icon(
          Icons.person_outline,
          size: 24,
          color: Colors.black87,
        ),
      ),
    );
  }
}

// ==========================
// Hover Text Button
// ==========================
class _HoverTextButton extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget? trailingIcon;

  const _HoverTextButton({required this.title, this.onTap, this.trailingIcon});

  @override
  State<_HoverTextButton> createState() => _HoverTextButtonState();
}

class _HoverTextButtonState extends State<_HoverTextButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.orange.shade200 : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              if (widget.trailingIcon != null) ...[
                const SizedBox(width: 6),
                widget.trailingIcon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================
// Hover Dropdown
// ==========================
class _HoverDropdown extends StatefulWidget {
  final String title;
  final List<String> items;
  final Function(String)? onSelected;

  const _HoverDropdown({
    required this.title,
    required this.items,
    this.onSelected,
  });

  @override
  State<_HoverDropdown> createState() => _HoverDropdownState();
}

class _HoverDropdownState extends State<_HoverDropdown> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Theme(
        data: Theme.of(context).copyWith(
          popupMenuTheme: PopupMenuThemeData(
            color: Colors.white,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.dmSans(fontSize: 14, color: Colors.black87),
          ),
        ),
        child: PopupMenuButton<String>(
          onSelected: (value) {
            widget.onSelected?.call(value);
          },
          itemBuilder: (context) => widget.items
              .map(
                (item) => PopupMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      if (widget.title == "Products") ...[
                        _getProductImage(item),
                        const SizedBox(width: 8),
                      ],
                      Expanded(child: _HoverableMenuItem(text: item)),
                    ],
                  ),
                ),
              )
              .toList(),

          offset: const Offset(0, 40),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: _isHovered ? Colors.orange.shade200 : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.title,
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getProductImage(String product) {
    String imagePath;
    switch (product.toLowerCase()) {
      case 'cameras':
        imagePath = 'assets/images/icons/video-camera.png';
        break;
      case 'tvs':
        imagePath = 'assets/images/icons/television.png';
        break;
      case 'speakers':
        imagePath = 'assets/images/icons/speaker.png';
        break;
      case 'microphones':
        imagePath = 'assets/images/icons/microphone.png';
        break;
      default:
        imagePath = 'assets/images/icons/tripod.png';
    }

    return Image.asset(imagePath, height: 22, width: 21, fit: BoxFit.contain);
  }
}

// ==========================
// Hoverable Dropdown Item
// ==========================
class _HoverableMenuItem extends StatefulWidget {
  final String text;

  const _HoverableMenuItem({required this.text});

  @override
  State<_HoverableMenuItem> createState() => _HoverableMenuItemState();
}

class _HoverableMenuItemState extends State<_HoverableMenuItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: _hovering ? Colors.orange.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.text,
          style: GoogleFonts.dmSans(fontSize: 14, color: Colors.black87),
        ),
      ),
    );
  }
}
