import 'dart:math';
import 'package:edukasi_card/card_image_paths.dart';
import 'package:edukasi_card/khusus.dart';
import 'package:edukasi_card/tantangan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeController extends GetxController {
  GetStorage box = GetStorage();
  final conTantangan = FlipCardController();
  final conKhusus = FlipCardController();
  var lastRan = 0;

  var question = {
    "pertanyaan": "Apa fungsi utama dari lambung?",
    "jawaban": "Menghancurkan makanan"
  }.obs;

  var khususon = {
    "judul_kartu": "Serat Sehat!",
    "emoji": "🥦",
    "isi_kartu":
        "Makanan berserat membantu ususmu. Pilih satu pemain untuk mundur 1 langkah."
  }.obs;

  var text =
      "Kamu minum air putih tepat waktu! Maju 2 langkah dan lewati soal berikutnya.";

  void changeQuetion() {
    question.value = getRandomCard(Tantangan.question);
  }

  void changeKhususon() {
    khususon.value = getRandomCard(Khusus.question);
  }

  void flipTantangan() {
    if(!conKhusus.state!.isFront) conKhusus.flipcard();
    conTantangan.flipcard();
    print(conTantangan.state!.isFront);
    if(!conTantangan.state!.isFront){
      changeQuetion();
    }
  }

  void flipKhusus() {
    if(!conTantangan.state!.isFront) conTantangan.flipcard();
    conKhusus.flipcard();
    print(conKhusus.state!.isFront);
    if (!conKhusus.state!.isFront) {
      changeKhususon();
    }
  }

  Map<String, String> getRandomCard(List<Map<String, String>> cards) {
    if (cards.isEmpty) throw Exception('List is empty');

    if (cards.length == 1) {
      lastRan = 0;
      return cards[0];
    }

    final random = Random();
    int res;

    do {
      res = random.nextInt(cards.length);
    } while (res == lastRan);

    lastRan = res;
    return cards[res];
  }

  void showCardDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Gambar kartu sebagai latar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Atur besar radius sesuai kebutuhan
                  child: Image.asset(
                    CardImagePaths.faceJawaban,
                    fit: BoxFit.contain,
                  ),
                ),


                // Teks di tengah gambar
                Container(
                  width: Get.width * 0.6,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Obx(() => Text(
                    question['jawaban'] ?? 'Kosong',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.fredoka(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
                ),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: (){
                conTantangan.flipcard();
                Get.back();
              },
              child: const Text(
                'Kembali',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
      barrierColor: Color(0xEA050505),
    );
  }

}
