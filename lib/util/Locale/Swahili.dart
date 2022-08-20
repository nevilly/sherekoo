class Swahili {
  Swahili(
    this.key,
  );

  final int key;
  List dictionary = [
    "Sherekoo",
    "Sim namba",
    "Nywila",
    "Sahau Nywila",  
    "Ingia",     //5
    "Akaunti mpya..?",
    "Umekosea Simu namba au Nywila",
    "Ingaza Nywila zako...",
    "Ingaza Simu Namba zako...",
    "",   // 10
    "Badili lugha",
    "",
    ""
  ];

  words() {
    return dictionary[key];
  }
}
