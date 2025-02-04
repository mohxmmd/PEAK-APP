import 'package:flutter/material.dart';
import 'package:peak_app/utils/dimensions.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpInputWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController otpController;

  const OtpInputWidget({
    super.key,
    required this.formKey,
    required this.otpController,
  });
  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = Theme.of(context).textTheme.displayLarge!;

    return Form(
      key: formKey,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 300, // Set the maximum width for the OTP box
          ),
          child: Padding(
            padding: EdgeInsets.only(top: Dimensions.heightSize * 4),
            child: PinFieldAutoFill(
              controller: otpController,
              codeLength: 4,
              keyboardType: TextInputType.number,
              decoration: BoxLooseDecoration(
                textStyle: labelStyle,
                bgColorBuilder: const FixedColorBuilder(Colors.transparent),
                strokeColorBuilder: const FixedColorBuilder(
                  Color(0xFF858683),
                ),
                gapSpace: 35.0,
                strokeWidth: 1.0,
                radius: const Radius.circular(12),
              ),
              onCodeSubmitted: (code) {
                otpController.text = code;
              },
              onCodeChanged: (code) {},
            ),
          ),
        ),
      ),
    );
  }
}
