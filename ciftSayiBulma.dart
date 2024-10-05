import 'dart:io';

void sayiGirdisi() {
  while (true) {
    List<int> sayilar = [];

    for (int i = 1; i <= 10; i++) {
      print("$i. sayıyı girin:");
      int sayi = int.parse(stdin.readLineSync()!);
      sayilar.add(sayi);
    }

    print("Girilen sayılar: $sayilar");

    List<int> ciftSayilar = sayilar.where((sayi) => sayi % 2 == 0).toList();

    if (ciftSayilar.isNotEmpty) {
      print("Girilen çift sayılar: $ciftSayilar");
      break;
    } else {
      print("Listede hiç çift sayı yok. Tekrar deneyin.");
    }
  }
}

void main() {
  sayiGirdisi();
}
