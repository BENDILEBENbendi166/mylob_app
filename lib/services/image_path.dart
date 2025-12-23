String hotelImage(String filename) {
  if (filename.startsWith('assets/')) return filename;
  return 'assets/images/hotels/$filename';
}

String cityImage(String filename) {
  if (filename.startsWith('assets/')) return filename;
  return 'assets/images/cities/$filename';
}
