// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:zenpuku/routes.dart';
// import 'gita.dart';
// import 'dart:math';

// class Book {
//   final String summary;
//   final String author;
//   final String title;
//   final String link;

//   Book({
//     required this.summary,
//     required this.author,
//     required this.title,
//     required this.link,
//   });
// }

// class Books extends StatefulWidget {
//   @override
//   _BooksState createState() => _BooksState();
// }

// class _BooksState extends State<Books> {
//   List<Book> books = [];
//   GitaQuote? _currentQuote;
//   List<GitaQuote>? _gitaQuotes;

//   @override
//   void initState() {
//     super.initState();
//     fetchBooks();
//     fetchGitaQuotes();
//   }

//   Future<void> fetchGitaQuotes() async {
//     final quotesService = GitaQuotesService();
//     final quotes = await quotesService.fetchQuotes();
//     final random = Random();
//     final index = random.nextInt(quotes.length);
//     setState(() {
//       _gitaQuotes = quotes;
//       _currentQuote = quotes.isNotEmpty ? quotes[index] : null;
//     });
//   }

//   Future<void> fetchBooks() async {
//     final response = await http.get(
//       Uri.parse(
//           'https://adhiraj-11.github.io/Zenpuku_Ignitia/books/booksummary.json'),
//     );
//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       final bookData = jsonData['books'];
//       if (bookData != null && bookData is Iterable) {
//         final List<Book> fetchedBooks = [];
//         for (var book in bookData) {
//           final q = Book(
//             link: book['link'],
//             title: book['title'],
//             summary: book['summary'],
//             author: book['author'],
//           );
//           fetchedBooks.add(q);
//         }
//         setState(() {
//           books = fetchedBooks;
//         });
//       }
//     }
//   }

//   void navigateToBookPage(Book book) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BookPage(book: book),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFB799FF), // Updated background color
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Greeting section
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.95,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.white,
//                       width: 2,
//                     ),
//                     //  color: Color(0xFFB799FF),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Padding(

//                     padding: const EdgeInsets.all(8.0),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Row(
//                         children: [
//                           Text(
//                             _getGreeting(),
//                             style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Icon(
//                             Icons.mood,
//                             color: Colors.white,)
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // Books section
//               Text(
//                 "Books",
//                 style: GoogleFonts.mukta(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Container(
//                 height: 150,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: books.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final book = books[index];
//                     return GestureDetector(
//                       onTap: () => navigateToBookPage(book),
//                       child: Container(
//                         margin: EdgeInsets.all(8),
//                         width: 200,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(8),
//                             child: Text(
//                               book.title,
//                               style: GoogleFonts.abel(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               // Activities section
//               SizedBox(height: 20),
//               Text(
//                 "Activities",
//                 style: GoogleFonts.mukta(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pushNamed(
//                         breatheRoute,
//                       );
//                     },
//                     child: Text(
//                       "Breathing",
//                       style: GoogleFonts.mukta(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pushNamed(
//                         matchingRoute,
//                       );
//                     },
//                     child: Text(
//                       "Memory Match",
//                       style: GoogleFonts.mukta(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               // Card with Gita quote
//               SizedBox(height: 20),
//               Card(
//                 color: Colors.white,
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Text(
//                         _currentQuote?.quote ?? 'Loading quote...',
//                         style: TextStyle(fontSize: 18),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             _currentQuote = null;
//                           });
//                           fetchGitaQuotes();
//                         },
//                         child: Text('Refresh Quote'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Calendar section
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pushNamed(
//                     heatmapRoute,
//                   );
//                 },
//                 child: Text(
//                   "Meditation",
//                   style: GoogleFonts.mukta(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String _getGreeting() {
//     var hour = DateTime.now().hour;
//     if (hour < 12) {
//       return 'Good morning!';
//     } else if (hour < 17) {
//       return 'Good afternoon!';
//     } else {
//       return 'Good evening!';
//     }
//   }
// }

// class BookPage extends StatelessWidget {
//   final Book book;

//   BookPage({required this.book});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey, // Updated background color
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 book.title,
//                 style: GoogleFonts.mukta(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'by ${book.author}',
//                 style: GoogleFonts.mukta(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () {},
//                 child: Text(
//                   "BUY NOW",
//                   style: GoogleFonts.mukta(
//                     fontSize: 20,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Summary:',
//                 style: GoogleFonts.mukta(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 book.summary,
//                 style: GoogleFonts.amiri(
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenpuku/routes.dart';
import 'bookView.dart';
import 'gita.dart';
import 'dart:math';

class Book {
  final String summary;
  final String author;
  final String title;
  final String link;

  Book({
    required this.summary,
    required this.author,
    required this.title,
    required this.link,
  });
}

class Books extends StatefulWidget {
  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  List<Book> books = [];
  GitaQuote? _currentQuote;
  List<GitaQuote>? _gitaQuotes;

  @override
  void initState() {
    super.initState();
    fetchBooks();
    fetchGitaQuotes();
  }

  Future<void> fetchGitaQuotes() async {
    final quotesService = GitaQuotesService();
    final quotes = await quotesService.fetchQuotes();
    final random = Random();
    final index = random.nextInt(quotes.length);
    setState(() {
      _gitaQuotes = quotes;
      _currentQuote = quotes.isNotEmpty ? quotes[index] : null;
    });
  }

  Future<void> fetchBooks() async {
    final response = await http.get(
      Uri.parse(
          'https://adhiraj-11.github.io/Zenpuku_Ignitia/books/booksummary.json'),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final bookData = jsonData['books'];
      if (bookData != null && bookData is Iterable) {
        final List<Book> fetchedBooks = [];
        for (var book in bookData) {
          final q = Book(
            link: book['link'],
            title: book['title'],
            summary: book['summary'],
            author: book['author'],
          );
          fetchedBooks.add(q);
        }
        setState(() {
          books = fetchedBooks;
        });
      }
    }
  }

  void navigateToBookPage(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookPage(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB799FF), // Updated background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting section
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    //  color: Color(0xFFB799FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(

                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            _getGreeting(),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.mood,
                            color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Books section
              Text(
                "Books",
                style: GoogleFonts.mukta(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  itemBuilder: (BuildContext context, int index) {
                    final book = books[index];
                    return GestureDetector(
                      onTap: () => navigateToBookPage(book),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              book.title,
                              style: GoogleFonts.abel(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Activities section
              SizedBox(height: 20),
              Text(
                "Activities",
                style: GoogleFonts.mukta(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        breatheRoute,
                      );
                    },
                    child: Text(
                      "Breathing",
                      style: GoogleFonts.mukta(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        matchingRoute,
                      );
                    },
                    child: Text(
                      "Memory Match",
                      style: GoogleFonts.mukta(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              // Card with Gita quote
              SizedBox(height: 20),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        _currentQuote?.quote ?? 'Loading quote...',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentQuote = null;
                          });
                          fetchGitaQuotes();
                        },
                        child: Text('Refresh Quote'),
                      ),
                    ],
                  ),
                ),
              ),

              // Calendar section
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    heatmapRoute,
                  );
                },
                child: Text(
                  "Meditation",
                  style: GoogleFonts.mukta(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning!';
    } else if (hour < 17) {
      return 'Good afternoon!';
    } else {
      return 'Good evening!';
    }
  }
}
