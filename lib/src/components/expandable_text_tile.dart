import 'package:flutter/material.dart';

class ExpandableTextTile extends StatelessWidget {
  final String title;
  final String text;
  final IconData icon;

  const ExpandableTextTile({
    super.key,
    required this.title,
    required this.text,
    this.icon = Icons.info_outline,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(left: 0, right: 15),
      title: Text(title),
      shape: const Border(),
      controlAffinity: ListTileControlAffinity.trailing,
      initiallyExpanded: false,
      children: <Widget>[
        ListTile(
          leading: Icon(icon),
          title: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              bool isExpanded = false;
              return StatefulBuilder(
                builder: (context, setState) {
                  final span = TextSpan(text: text);
                  final tp = TextPainter(
                    text: span,
                    textDirection: TextDirection.ltr,
                    maxLines: 3,
                  );
                  tp.layout(maxWidth: MediaQuery.of(context).size.width);

                  if (tp.didExceedMaxLines) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          maxLines: isExpanded ? null : 3,
                          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                        ),
                        InkWell(
                          child: Text(
                            isExpanded ? 'show less' : 'show more',
                            style: const TextStyle(color: Colors.blue),
                          ),
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                        ),
                      ],
                    );
                  } else {
                    return Text(text);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
