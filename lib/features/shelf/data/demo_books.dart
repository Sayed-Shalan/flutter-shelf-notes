import '../domain/book.dart';

List<Book> demoBooks() {
  return const [
    Book(
      id: 'paper-cities',
      title: 'Paper Cities',
      author: 'Hana Mostafa',
      status: BookStatus.reading,
    ),
    Book(
      id: 'night-trains',
      title: 'Night Trains',
      author: 'Yusuf Nabil',
      status: BookStatus.queued,
    ),
    Book(
      id: 'salt-cedar',
      title: 'Salt and Cedar',
      author: 'Mariam Fathy',
      status: BookStatus.finished,
    ),
  ];
}
