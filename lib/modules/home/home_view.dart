import 'package:edukasi_card/card_image_paths.dart';
import 'package:edukasi_card/modules/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cardKhusus(),
              SizedBox(height: 60,),
              cardTantangan(),
            ],
          ),
        ),

      ),
    );
  }

  Widget cardKhusus(){
    return GestureDetector(
      onTap: controller.flipKhusus,
      child: Container(
        child: Center(
          child: FlipCard(
              rotateSide: RotateSide.left,
              onTapFlipping: false,
              controller: controller.conKhusus,
              axis: FlipAxis.vertical,
              animationDuration: const Duration(milliseconds: 400),
              frontWidget: Center(
                child: Container(
                  child: Image.asset(
                    CardImagePaths.backSideKhusus,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              backWidget: Container(
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        CardImagePaths.faceKhusus,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width / 1.3,
                              child: Text(
                                controller.khususon['judul_kartu'] ?? 'kosong',
                                style: GoogleFonts.fredoka(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: Get.width / 1.7,
                              child: Text(
                                controller.khususon['emoji'] ?? 'kosong',
                                style: GoogleFonts.fredoka(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: Get.width / 1.7,
                              child: Text(
                                controller.khususon['isi_kartu'] ?? 'kosong',
                                style: GoogleFonts.fredoka(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  Widget cardTantangan() {
    return GestureDetector(
      onTap:controller.flipTantangan,
      child: Container(
        child: Center(
          child: FlipCard(
            rotateSide: RotateSide.left,
            onTapFlipping: false,
            controller: controller.conTantangan,
            axis: FlipAxis.vertical,
            animationDuration: const Duration(milliseconds: 400),
            frontWidget: Center(
              child: Container(
                child: Image.asset(
                  CardImagePaths.backSideTantangan,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            backWidget: Container(
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      CardImagePaths.faceTantangan,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        width: Get.width / 1.7,
                        child: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: 20,),
                            Text(
                              controller.question['pertanyaan'] ?? 'kosong',
                              style: GoogleFonts.fredoka(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5,),
                            buttonJawaban()
                          ],
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

  Widget buttonJawaban(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Warna latar belakang tombol
        foregroundColor: Colors.white, // Warna teks
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      onPressed: () {
        controller.showCardDialog();
      },
      child: const Text(
        'Jawaban',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}
