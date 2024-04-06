import 'package:flutter/material.dart';
import '../../../globalwidgets/base_textfield.dart';

class PostInfoCard extends StatelessWidget {
  GlobalKey<FormState> infoFormKey;
  PostInfoCard(this.infoFormKey, {super.key});

  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  String? title;
  String? description;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: infoFormKey,
      child: Column(
        children: [
          const SizedBox(height: 5),
          BaseTextField(
            focusNode: _titleFocusNode,
            nexFocusNode: _descriptionFocusNode,
            minLines: 1,
            maxLines: 5,
            maxLength: 255,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: titleTextController,
            labelText: 'Tiêu đề',
            hintText: 'Nhập tiều đề',
            onSaved: (value) {
              title = value!.trim();
            },
            validator: (value) =>
                (value!.trim().isNotEmpty) ? null : 'Tiêu đề không được rỗng',
          ),
          const SizedBox(height: 10),
          BaseTextField(
            focusNode: _descriptionFocusNode,
            minLines: 3,
            maxLines: 10,
            maxLength: 1000,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller: descriptionTextController,
            labelText: 'Mô tả chi tiết',
            hintText: 'Mô tả chi tiết',
            onSaved: (value) {
              description = value!.trim();
            },
            validator: (value) =>
                (value!.trim().isNotEmpty) ? null : 'Mô tả không được rỗng',
          ),
        ],
      ),
    );
  }
}
