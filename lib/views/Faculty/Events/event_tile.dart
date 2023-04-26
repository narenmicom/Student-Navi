import 'package:code/utilities/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/link.dart';

class EventTile extends StatelessWidget {
  final EventsDetails eventsDetails;
  const EventTile({
    super.key,
    required this.eventsDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
          onTap: () {
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) =>
            //         _addSubjectPopup(
            //             context, snapshot.data[index]));
          },
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 6, bottom: 6),
                        child: CachedNetworkImage(
                          width: 100,
                          imageUrl: eventsDetails.posterLink,
                          placeholder: (context, url) => Container(
                            width: 50,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(
                          minWidth: 220,
                          maxWidth: 270,
                          minHeight: 120,
                          maxHeight: 160,
                        ),
                        padding: const EdgeInsets.only(
                            left: 1, right: 2, top: 15, bottom: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              eventsDetails.ename,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              eventsDetails.date,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${eventsDetails.startTime} - ${eventsDetails.endTime}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'By ${eventsDetails.organiser}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Link(
                                target: LinkTarget.blank,
                                uri: Uri.parse(''),
                                builder: (context, followLink) =>
                                    GestureDetector(
                                  onTap: followLink,
                                  child: const Text(
                                    'LINK',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      // tilePadding: EdgeInsets.all(8),
                      childrenPadding: EdgeInsets.all(16),
                      title: const Text(
                        'Show More',
                      ),
                      children: [
                        Text(
                          eventsDetails.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 50,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
