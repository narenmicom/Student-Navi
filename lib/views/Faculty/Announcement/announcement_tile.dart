import 'package:code/utilities/data_classes.dart';
import 'package:code/views/Faculty/Subjects/pdf_viewer.dart';
import 'package:flutter/material.dart';

class AnnouncementTile extends StatelessWidget {
  final AnnouncementDetails announcementDetails;
  const AnnouncementTile({
    super.key,
    required this.announcementDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 6),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width - 30,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      announcementDetails.date,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      announcementDetails.month,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      announcementDetails.year,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                const VerticalDivider(
                                  thickness: 2,
                                ),
                                Flexible(
                                  child: Text(
                                    announcementDetails.announcementName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  announcementDetails.issuingAuthority,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PdfViwer(
                                        fileLink:
                                            announcementDetails.attachmentLink,
                                        noteName: announcementDetails
                                            .announcementType,
                                      ),
                                    ),
                                  );
                                },
                                // icon: Icon(
                                //   color: Colors.white,
                                //   Icons.expand_more,
                                //   size: 20.0,
                                // ),
                                child: const Text(
                                  'Read More',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
