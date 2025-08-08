import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Footer extends StatelessWidget {
  Footer({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  Future<void> sendEmail(BuildContext context) async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        messageController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('❗ Please fill all fields')));
      return;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('❗ Enter a valid email')));
      return;
    }

    const serviceId = 'service_5h3d0bj';
    const templateId = 'template_2msrc5q';
    const userId = 'hBy2AaG7ub7qnuFXp';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': nameController.text,
          'user_phone': phoneController.text,
          'user_email': emailController.text,
          'user_message': messageController.text,
        },
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Email sent successfully')),
      );
      nameController.clear();
      phoneController.clear();
      emailController.clear();
      messageController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed to send: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 60,
            vertical: isMobile ? 40 : 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLeftColumn(),
                        const SizedBox(height: 30),
                        _buildRightColumn(context),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildLeftColumn()),
                        const SizedBox(width: 40),
                        Expanded(flex: 3, child: _buildRightColumn(context)),
                      ],
                    ),
              const SizedBox(height: 40),
              const Divider(color: Colors.white24),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _copyrightText(),
                          const SizedBox(height: 16),
                          _buildSocialIcons(),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [_copyrightText(), _buildSocialIcons()],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _copyrightText() {
    return Text(
      '© 2025 Tortoise Techno Solutions Pvt Ltd. All Rights Reserved.',
      style: GoogleFonts.dmSans(color: Colors.white70, fontSize: 13),
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/tortoise_logo.png', height: 60),
        const SizedBox(height: 20),
        Text(
          'Tortoise Techno Solutions Pvt Ltd',
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'VII/405, Ground Floor,\nMadaparambil Arcade,\nOushadhi Junction,\nPerumbavoor, Ernakulam,\nKerala, Pin: 683542',
          style: GoogleFonts.dmSans(
            color: Colors.white70,
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '📞 7025890891, 9061101169\n📧 accounts@tortoisetech.in\n🕘 Mon-Sat: 10 AM – 5 PM\n⛔ Sunday: Holiday',
          style: GoogleFonts.dmSans(
            color: Colors.white70,
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'GET A ',
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'FREE ',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: 'CONSULTATION'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _inputField('Your Name', nameController),
          const SizedBox(height: 12),
          _inputField('Your Phone Number', phoneController),
          const SizedBox(height: 12),
          _inputField('Your Email', emailController),
          const SizedBox(height: 12),
          _inputField('Your Message', messageController),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => sendEmail(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 8,
            ),
            icon: const Icon(Icons.send),
            label: const Text(
              'Request Free Quote',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white60),
        filled: true,
        fillColor: Colors.black26,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      children: [
        _socialIcon(FontAwesomeIcons.facebookF, Colors.blue),
        const SizedBox(width: 16),
        _socialIcon(FontAwesomeIcons.envelope, Colors.orangeAccent),
        const SizedBox(width: 16),
        _socialIcon(FontAwesomeIcons.phone, Colors.white),
        const SizedBox(width: 16),
        _socialIcon(FontAwesomeIcons.whatsapp, Colors.green),
        const SizedBox(width: 16),
        _socialIcon(FontAwesomeIcons.instagram, Colors.pinkAccent),
      ],
    );
  }

  Widget _socialIcon(IconData icon, Color color) {
    return InkWell(
      onTap: () {}, // Optional: Add action
      child: FaIcon(icon, color: color, size: 18),
    );
  }
}
