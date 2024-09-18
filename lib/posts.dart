import 'package:flutter/material.dart';
import 'http_service.dart';
import 'post_model.dart';
import 'detail_page.dart';
import 'profile_page.dart'; // Import halaman Profile

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final HttpService httpService = HttpService();
  int _selectedIndex = 0; // Menyimpan indeks tab yang dipilih

  // Daftar halaman untuk bottom navigation
  final List<Widget> _pages = [
    PostsPageBody(), // Halaman Berita
    ProfilePage(),   // Halaman Profile
  ];

  // Fungsi untuk mengubah indeks halaman saat tab ditekan
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Berita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange, // Warna oranye untuk elemen terpilih
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black, // Background bottom navigation menjadi gelap
        onTap: _onItemTapped,
      ),
    );
  }
}

// Komponen terpisah untuk menampilkan halaman Berita (Posts)
class PostsPageBody extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "akmal.com",
          style: TextStyle(
            fontFamily: 'BebasNeue',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.orange, // Warna oranye untuk logo
          ),
        ),
        backgroundColor: Colors.grey[850], // Warna abu-abu untuk AppBar
        elevation: 0,
      ),
      body: Container(
        color: Colors.black, // Warna hitam pekat untuk body
        child: FutureBuilder<ApiResponse>(
          future: httpService.getPosts(),
          builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.data.posts.isEmpty) {
              return Center(child: Text("No posts available."));
            } else {
              List<Post> posts = snapshot.data!.data.posts;

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Post post = posts[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(post: post),
                        ),
                      );
                    },
                    child: BookCard(
                      title: post.title,
                      coverUrl: post.thumbnail,
                      id: post.link.hashCode,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String title;
  final String coverUrl;
  final int id;

  const BookCard({Key? key, required this.title, required this.coverUrl, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                coverUrl,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.2), // Efek gelap lebih ringan pada gambar
                colorBlendMode: BlendMode.darken,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.6),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "ID: ${id.toString()}",
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
