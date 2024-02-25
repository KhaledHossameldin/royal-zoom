import 'package:flutter/material.dart';

class VoiceMessageWidget extends StatelessWidget {
  const VoiceMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

  // if (messages[index].contentType ==
                                  //     ChatContentType.voice) {
                                  //   // if (messages[index].player == null) {
                                  //   //   return Text(
                                  //   //       appLocalizations.cannotPlayAudio);
                                  //   // }
                                  //   return Row(
                                  //     children: [
                                  //       Text(
                                  //         messages[index]
                                  //             .player!
                                  //             .duration!
                                  //             .audioTime,
                                  //         style: TextStyle(
                                  //           fontSize: 9.0,
                                  //           color: isSelf
                                  //               ? BrandColors.black
                                  //               : BrandColors.snowWhite,
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       ),
                                  //       8.emptyWidth,
                                  //       // Expanded(
                                  //       //   child: StreamBuilder(
                                  //       //     stream: messages[index]
                                  //       //         .player!
                                  //       //         .positionStream,
                                  //       //     builder: (context, snapshot) =>
                                  //       //         Directionality(
                                  //       //       textDirection: TextDirection.ltr,
                                  //       //       child: LinearProgressIndicator(
                                  //       //         color: isSelf
                                  //       //             ? BrandColors.darkGreen
                                  //       //             : BrandColors.snowWhite,
                                  //       //         backgroundColor: Colors.grey,
                                  //       //         value: (snapshot.data ??
                                  //       //                     Duration.zero)
                                  //       //                 .inSeconds /
                                  //       //             max(
                                  //       //                 messages[index]
                                  //       //                     .player!
                                  //       //                     .duration!
                                  //       //                     .inSeconds,
                                  //       //                 1),
                                  //       //       ),
                                  //       //     ),
                                  //       //   ),
                                  //       // ),
                                  //       8.emptyWidth,
                                  //       FloatingActionButton.small(
                                  //         elevation: 0.0,
                                  //         backgroundColor: isSelf
                                  //             ? BrandColors.darkGreen
                                  //             : BrandColors.snowWhite,
                                  //         heroTag: 'id-${messages[index].id}',
                                  //         child: Icon(
                                  //           Icons.play_arrow_rounded,
                                  //           color: !isSelf
                                  //               ? BrandColors.darkGreen
                                  //               : null,
                                  //         ),
                                  //         onPressed: () async {
                                  //           await messages[index]
                                  //               .player!
                                  //               .seek(Duration.zero);
                                  //           messages[index].player!.play();
                                  //         },
                                  //       ),
                                  //     ],
                                  //   );
                                  // }