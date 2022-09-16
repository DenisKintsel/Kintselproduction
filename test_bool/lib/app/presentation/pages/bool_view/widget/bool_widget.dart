import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../core_global/colors/colors.dart';
import '../../../../domain/entities/list_bool_model.dart';
import '../../../widget/object_bool.dart';

class ListBool extends StatefulWidget {
  final listBoolModel output;
  final Function(int, int, int, int, int, int, int, int, int, int, int, int)
      syncingBool;
  final Function(List<Map<String, int>>) hiveSyncing;
  final VoidCallback onRefresh;

  const ListBool(
      {super.key,
      required this.syncingBool,
      required this.onRefresh,
      required this.output,
      required this.hiveSyncing});

  @override
  _ListBool createState() => _ListBool();
}

class _ListBool extends State<ListBool> {
  List<Map<String, int>> outbool2 = [];

  @override
  void initState() {
    super.initState();
    progress();
    progressHive();
  }

  progress() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      checkChanges();
    });
  }

  progressHive() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      hiveSync();
    });
  }

  checkChanges() {
    widget.syncingBool.call(
      outbool2[0]['id']!,
      outbool2[0]['switchQ']!,
      outbool2[0]['radio']!,
      outbool2[0]['checkBox']!,
      outbool2[1]['id']!,
      outbool2[1]['switchQ']!,
      outbool2[1]['radio']!,
      outbool2[1]['checkBox']!,
      outbool2[2]['id']!,
      outbool2[2]['switchQ']!,
      outbool2[2]['radio']!,
      outbool2[2]['checkBox']!,
    );
  }

  hiveSync() {
    widget.hiveSyncing.call(outbool2);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, int>> outbool = [
      {'id': 0, 'switchQ': 0, 'radio': 0, 'checkBox': 0},
      {'id': 0, 'switchQ': 0, 'radio': 0, 'checkBox': 0},
      {'id': 0, 'switchQ': 0, 'radio': 0, 'checkBox': 0}
    ];
    outbool2 = outbool;
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 68,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "List",
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 32,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => widget.onRefresh.call(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.output.listBool.length,
                        itemBuilder: (context, index) {
                          outbool2[index]['id'] =
                              widget.output.listBool[index]['id'];
                          outbool2[index]['switchQ'] =
                              widget.output.listBool[index]['switchQ'];
                          outbool2[index]['radio'] =
                              widget.output.listBool[index]['radio'];
                          outbool2[index]['checkBox'] =
                              widget.output.listBool[index]['checkBox'];
                          return Column(
                            children: [
                              const SizedBox(height: 24.0),
                              ObjectBoolWidget(
                                title: widget.output.listBool[index]['id'],
                                check: widget.output.listBool[index]
                                    ['checkBox'],
                                status: widget.output.listBool[index]
                                    ['switchQ'],
                                radio: widget.output.listBool[index]['radio'],
                                onSwitch: (value) {
                                  outbool2[index]['switchQ'] = value;
                                },
                                onRadio: (value) {
                                  outbool2[index]['radio'] = value;
                                },
                                onCheckbox: (value) {
                                  outbool2[index]['checkBox'] = value;
                                },
                              ),
                              Container(
                                  color: AppColors.backgroundPrimary2,
                                  height: 4)
                            ],
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
