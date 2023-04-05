import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Switch to Dark Mode',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Container(
                width: 80,
                height: 40,
                child: Stack(
                  alignment: AlignmentDirectional(0, 0),
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.95, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: Icon(
                          Icons.nights_stay,
                          color: Color(0xFF95A1AC),
                          size: 20,
                        ),
                      ),
                    ),
                    // Align(
                    //   alignment: AlignmentDirectional(-0.85, 0),
                    //   child: Container(
                    //     width: 36,
                    //     height: 36,
                    //     decoration: BoxDecoration(
                    //       color: Color(0xFF101213),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           blurRadius: 4,
                    //           color: Color(0x430B0D0F),
                    //           offset: Offset(0, 2),
                    //         )
                    //       ],
                    //       borderRadius: BorderRadius.circular(30),
                    //       shape: BoxShape.rectangle,
                    //     ),
                    //   ).animateOnActionTrigger(
                    //     animationsMap['containerOnActionTriggerAnimation1']!,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
