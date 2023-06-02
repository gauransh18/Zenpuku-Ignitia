// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenpuku/routes.dart';
import 'gita.dart';
import 'dart:math';

class Book {
  // final String id;
  final String summary;
  final String author;
  final String title;

  Book({required this.summary, required this.author, required this.title});
}

class Books extends StatefulWidget {
  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  List<Book> books = [];
  //
  //
  //
  GitaQuote? _currentQuote;
  List<GitaQuote>? _gitaQuotes;

  @override
  void initState() {
    super.initState();
    fetchBooks();
    //
    //
    //
    fetchGitaQuotes();
  }

  //
  //
  //
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


  // Future<void> fetchBooks() async {
  //  // final response = await http.get(Uri.parse('http://localhost:8000/tester1.html'));
  //  //final response = await http.get(Uri.parse('https://dummyjson.com/quotes'));

  //   final response = await http.get(Uri.parse('https://vihanagarwal18.github.io/host/tester3.json'));
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     final bookData = jsonData['books'];
  //     final List<Book> fetchedBooks = [];
  //     for (var quote in bookData) {
  //       final q = Book(

  //         summary: quote['summary'],
  //         author: quote['author'],
  //       );
  //       fetchedBooks.add(q);
  //     }
  //     setState(() {
  //       books = fetchedBooks;
  //     });
  //   }
  // }

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse(
        'https://adhiraj-11.github.io/Zenpuku_Ignitia/books/booksummary.json'));
// final response = await http.get(Uri.parse('https://vihanagarwal18.github.io/host/tester3.json'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final bookData = jsonData['books']; //to be changed to books
      if (bookData != null && bookData is Iterable) {
        final List<Book> fetchedBooks = [];
        for (var book in bookData) {
          final q = Book(
            title: book['title'],
            summary: book['summary'], //to be changed to summary
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

  void navigateToBookPage(Book summary) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookPage(book: summary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
//     Container(
//             height: 150,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: books.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final book = books[index];
//                 return GestureDetector(
//                   onTap: () => navigateToBookPage(book),
//                   child: Container(
//                     margin: EdgeInsets.all(8),
//                     width: 200,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'somethingsomething',
//                       //  quote.author,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );

//             }

//           ));  }

// }
        Scaffold(
      appBar: 
      AppBar(
        title: Text('Zenpuku'),
      ),
      body: Column(
        children: [
          //book row
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  "Books",
                  style: GoogleFonts.mukta(
                      fontSize: 30, fontWeight: FontWeight.bold),
                )),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
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
                        color: Color(0xFFDFE94E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'somethingsomething',
                          //  quote.author,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          //Activites

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  "Activites",
                  style: GoogleFonts.mukta(
                      fontSize: 30, fontWeight: FontWeight.bold),
                )),
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0,20,20,0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        breatheRoute,
                      );
                    },
                    child: Text(
                      "Breathing",
                      style: GoogleFonts.mukta(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ),
            
              Padding(padding: EdgeInsets.fromLTRB(0, 20 , 20, 20),),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      matchingRoute,
                    );
                  },
                  child: Text(
                    "Memory Match",
                    style: GoogleFonts.mukta(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              //IconButton(onPressed: (){}, icon: Icon(Icons.add_circle_outline,size: 50,), ),
            ],
          ),

          Card(
            margin: EdgeInsets.all(10),
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
                    //fetchGitaQuotes,
                    child: Text('Refresh Quote'),
                  ),
                ],
              ),
            ),
          ),

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
                      child: Text(
                        'somethingsomething',
                        //  quote.author,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
       

       
        ],
      ),
    );
  }
}

class BookPage extends StatelessWidget {
  final Book book;

  BookPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(book.title,
                  style: GoogleFonts.mukta(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              Text(
                'by ${book.author}',
                style: GoogleFonts.mukta(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Summary: ${book.summary}',
                style: GoogleFonts.amiri(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
