import 'dart:convert';
import 'package:http/http.dart' as http;

class GitaQuote {
  final String id;
  final String quote;

  GitaQuote({required this.id, required this.quote});

  factory GitaQuote.fromJson(Map<String, dynamic> json) {
    return GitaQuote(
      id: json['id'],
      quote: json['quote'],
    );
  }
}

class GitaQuotesService {
  Future<List<GitaQuote>> fetchQuotes() async {
    final response = await http.get(Uri.parse('https://adhiraj-11.github.io/Zenpuku_Ignitia/books/gita_quotes.json'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final quotesJson = jsonData['Quotes'] as List<dynamic>;
      return quotesJson
          .map((quoteJson) => GitaQuote.fromJson(quoteJson))
          .toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}
