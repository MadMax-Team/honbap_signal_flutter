import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:honbap_signal_flutter/models/signal/signal_info_model.dart';
import 'package:honbap_signal_flutter/screens/home/widgets/home_dialog/signal_on_dialog_third_widget.dart';
import 'package:honbap_signal_flutter/widgets/common_signal_card_widget.dart';
import 'package:intl/intl.dart';
import '../../../../constants/gaps.dart';
import '../../../../constants/sizes.dart';

class SignalSecondDialog extends StatefulWidget {
  final BuildContext parentContext;
  final bool modify;

  const SignalSecondDialog({
    super.key,
    required this.parentContext,
    required this.modify,
  });

  @override
  State<SignalSecondDialog> createState() => _SignalSecondDialogState();
}

class _SignalSecondDialogState extends State<SignalSecondDialog> {
  late SignalInfoModel _signalInfo;

  @override
  void initState() {
    super.initState();
    _signalInfo = const SignalInfoModel();
  }

  String _checkTime() {
    var now = DateTime.now();
    now = now.toUtc().add(const Duration(hours: 9));
    String formatDate = DateFormat('yyyy.MM.dd  HH:mm').format(now); //format변경
    return formatDate;
  }

  void _onChange(SignalInfoModel newSignalInfo) {
    setState(() {
      _signalInfo = newSignalInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        //contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 20,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Gaps.v16,
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(right: 3.0),
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                      Gaps.v18,
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.modify ? '시그널 글 수정' : '시그널 글 작성',
                              style: const TextStyle(
                                fontSize: Sizes.size18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Gaps.v6,
                            const Text(
                              '구체적인 시그널을 작성하여 매칭상대를 빠르게 찾아보세요',
                              style: TextStyle(
                                fontSize: Sizes.size12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff737373),
                              ),
                            ),
                            Gaps.v46,
                            CommonSignalCardWidget(
                              isBorder: false,
                              isEditable: true,
                              onChange: _onChange,
                              initSignal: _signalInfo,
                            ),
                          ],
                        ),
                      ),
                      Gaps.v16,
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: Text(
                          '시그널 생성일자 ${_checkTime()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: Sizes.size9,
                              color: Color(0xff8E8E8E)),
                        ),
                      ),
                      const SizedBox(height: 61),
                      Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 20.0),
                        decoration: BoxDecoration(
                          color: const Color(0xfff5f5f5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 20.0,
                                  color: Color(0xffc4c4c4),
                                ),
                                Gaps.h6,
                                Text(
                                  '유의사항',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: Sizes.size14,
                                    color: Color(0xffc4c4c4),
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v8,
                            Text(
                              '• 해당 내용은 매칭 후 상대방과 쪽지를 통해 조율가능합니다.\n• 홈>시그널글수정을 통해 수정가능합니다.',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Sizes.size14,
                                color: Color(0xffc4c4c4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          if(!widget.modify) {
                            showDialog(
                                context: context,
                                builder: (_) => SignalThirdBox(
                                    parentContext: widget.parentContext),
                                barrierDismissible: false);
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 22),
                          alignment: Alignment.center,
                          height: Sizes.size46,
                          width: double.maxFinite,
                          child: Text(
                            widget.modify ? '취소' : '건너뛰기',
                            style: const TextStyle(
                              fontSize: Sizes.size14,
                              color: Color(0xffC4C4C4),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if(widget.modify == false && _signalInfo.sigPromiseTime == null && _signalInfo.sigPromiseArea == null && _signalInfo.sigPromiseMenu == null) {
                            Fluttertoast.showToast(
                                msg: "시그널 정보를 입력해주세요!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                            );
                          } else {
                            Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                builder: (_) => SignalThirdBox(
                                  time: _signalInfo.sigPromiseTime,
                                  location: _signalInfo.sigPromiseArea,
                                  favoriteFood: _signalInfo.sigPromiseMenu,
                                  parentContext: widget.parentContext,
                                ),
                                barrierDismissible: false);
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 22),
                          alignment: Alignment.center,
                          height: Sizes.size46,
                          width: double.maxFinite,
                          child: Text(
                            widget.modify ? '수정완료' : '작성완료',
                            style: const TextStyle(
                              fontSize: Sizes.size14,
                              color: Color(0xffF35928),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
