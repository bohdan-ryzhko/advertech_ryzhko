import 'package:advertech_ryzhko/feedback_page/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  late FeedbackFormController feedbackFormController =
      Provider.of<FeedbackFormController>(context, listen: false);

  final _formKey = GlobalKey<FormState>();

  late bool isButtonEnabled = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final msgController = TextEditingController();

  String errorPlaceholder = "Please enter some text";

  @override
  void initState() {
    super.initState();
    nameController.addListener(updateButtonState);
    emailController.addListener(updateButtonState);
    msgController.addListener(updateButtonState);
  }

  String? validatorText(String? value) {
    if (value == null || value.isEmpty) {
      return errorPlaceholder;
    }
    return null;
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = nameController.text.isNotEmpty &&
          (emailController.text.isNotEmpty &&
              validatorEmail(emailController.text) == null) &&
          msgController.text.isNotEmpty;
    });
  }

  String? validatorEmail(String? value) {
    final isNotEmptyEmail = validatorText(value);

    if (isNotEmptyEmail != null) {
      return errorPlaceholder;
    }

    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value!);

    if (emailValid) {
      return null;
    }

    return "Enter valid email";
  }

  void onSubmit() {
    feedbackFormController.sendFeedback(
      name: nameController.text,
      email: emailController.text,
      message: msgController.text,
      context: context,
    );

    nameController.clear();
    emailController.clear();
    msgController.clear();
    setState(() {
      isButtonEnabled = false;
    });

    feedbackFormController.clearFeedback();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: feedbackFormController,
      builder: (BuildContext context, Widget? child) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   if (feedbackFormController.feedback.hasData) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text("Send message success!")),
        //     );
        //   } else if (feedbackFormController.feedback.hasError) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         content: Text("Message was not sent, please try again later"),
        //       ),
        //     );
        //   }
        // });
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: validatorText,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: validatorEmail,
                ),
                TextFormField(
                  controller: msgController,
                  decoration: const InputDecoration(
                    labelText: 'Message',
                  ),
                  validator: validatorText,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: isButtonEnabled ? onSubmit : null,
                    child: feedbackFormController.isLoad
                        ? const CircularProgressIndicator()
                        : const Text('Send'),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 50),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
