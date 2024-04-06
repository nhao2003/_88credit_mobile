import 'package:flutter/material.dart';
import '../../../globalwidgets/base_textfield.dart';

class PostInfoCard extends StatelessWidget {
  final GlobalKey<FormState> infoFormKey;
  final TextEditingController titleTextController;
  final TextEditingController descriptionTextController;

  PostInfoCard({
    required this.infoFormKey,
    required this.titleTextController,
    required this.descriptionTextController,
    super.key,
  });

  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

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
            validator: (value) =>
                (value!.trim().isNotEmpty) ? null : 'Mô tả không được rỗng',
          ),
        ],
      ),
    );
  }
}
