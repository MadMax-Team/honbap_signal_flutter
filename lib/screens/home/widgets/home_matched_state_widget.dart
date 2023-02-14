import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:honbap_signal_flutter/models/home/home_list_model.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_matched_user_tag_widget.dart';

class StateCard extends StatefulWidget {
  const StateCard({
    Key? key,
    required this.matchedInfo,
  }) : super(key: key);

  final MatchedInfo matchedInfo;

  @override
  State<StateCard> createState() => _StateCardState();
}

class _StateCardState extends State<StateCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                //그림자
                color: Color.fromRGBO(173, 173, 173, 0.2),
                blurRadius: 10.0,
                spreadRadius: -2,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(12), //모서리를 둥글게
          ),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(125)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(
                    widget.matchedInfo.image!,
                    fit: BoxFit.fill,
                    errorBuilder: ((context, error, stackTrace) =>
                        SvgPicture.asset(
                          'assets/icons/home_signal_list_box_user.svg',
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Text(
                widget.matchedInfo.name!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const Text(
                ' 님과 매칭되었습니다',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff737373)),
              )
            ],
          ),
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                height: 139,
                padding: const EdgeInsets.fromLTRB(8, 11, 8, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      //그림자
                      color: Color.fromRGBO(173, 173, 173, 0.2),
                      blurRadius: 10.0,
                      spreadRadius: -2,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12), //모서리를 둥글게
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '태그',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 103,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: [
                            for (int i = 1;
                                i < widget.matchedInfo.tag!.length;
                                i++)
                              MatchedUserTag(tag: widget.matchedInfo.tag![i])
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                height: 139,
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      //그림자
                      color: Color.fromRGBO(173, 173, 173, 0.2),
                      blurRadius: 10.0,
                      spreadRadius: -2,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12), //모서리를 둥글게
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '매너온도',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text('${widget.matchedInfo.temperature}')
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                height: 139,
                padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      //그림자
                      color: Color.fromRGBO(173, 173, 173, 0.2),
                      blurRadius: 10.0,
                      spreadRadius: -2,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12), //모서리를 둥글게
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '약속장소',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.matchedInfo.location!)
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
