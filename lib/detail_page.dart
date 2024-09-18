import 'package:flutter/material.dart';
import 'post_model.dart';

class NewsDetailPage extends StatelessWidget {
  final Post post;

  const NewsDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          post.title,
          style: TextStyle(color: Colors.white), // Warna oranye untuk teks AppBar
        ),
        backgroundColor: Colors.grey[850], // Warna abu-abu untuk AppBar
      ),
      body: Container(
        color: Colors.black, // Latar belakang hitam pekat untuk body
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post.thumbnail,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.2), // Efek gelap pada gambar
                  colorBlendMode: BlendMode.darken,
                ),
              ),
              SizedBox(height: 16),
              Text(
                post.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white, // Warna putih untuk judul
                ),
              ),
              SizedBox(height: 8),
              Text(
                post.pubDate,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    post.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Warna putih untuk deskripsi
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
