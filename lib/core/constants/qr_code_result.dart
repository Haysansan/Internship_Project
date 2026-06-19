enum QrCodeResult {
  getProduct('get_product'),
  complete('complete'),
  ;

  final String key;
  const QrCodeResult(this.key);
}
