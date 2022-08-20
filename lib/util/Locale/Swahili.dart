class Swahili {
  Swahili(
    this.key,
  );

  final int key;
  List dictionary = [
    "Sherekoo",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "Badili lugha",
    "",
    ""
  ];

  words() {
    return dictionary[key];
  }
}
