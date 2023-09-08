import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff666666), size: 20),
        backgroundColor: Colors.white,
        title: Text(
          "About",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xff666666),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Developer Communities',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
                'Developer communities play a vital role in the growth and learning of software developers. These communities bring together like-minded individuals who share knowledge, collaborate on projects, and support each other in their professional journeys.',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 16),
            Text(
                'This app is dedicated to celebrating and promoting developer communities around the world. It aims to provide a platform where developers can connect, learn, and engage with their peers.',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 16),
            Text('Features of the App:',
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 8),
            Text('- Browse and discover various developer communities.',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 3),
            Text(
                '- Join communities of your interest and participate in discussions.',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 3),
            Text(
                '- Access valuable resources, tutorials, and coding challenges.',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 3),
            Text('- Stay updated with community events and meetups.',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 3),
            Text('- Chat with each other in the community message group.',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 16),
            Text(
                'We believe that developer communities are the backbone of innovation, and we are committed to supporting and fostering these communities through this app.',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }
}
