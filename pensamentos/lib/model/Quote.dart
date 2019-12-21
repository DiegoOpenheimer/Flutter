

class Quote {

  String quote;
  String author;
  String image;

  Quote.fromMap(Map<String, dynamic> map) {
    quote = map['quote'];
    author = map['author'];
    image = map['image'];
  }

  @override
  String toString() {
    return 'Quote{quote: $quote, author: $author, image: $image}';
  }


}