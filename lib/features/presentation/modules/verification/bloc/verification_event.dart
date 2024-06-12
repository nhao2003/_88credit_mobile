part of 'verification_bloc.dart';

sealed class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class InitStateEvent extends VerificationEvent {}

class InitEkycEvent extends VerificationEvent {}

class ChangeStepEvent extends VerificationEvent {
  final int step;
  const ChangeStepEvent(this.step);

  @override
  List<Object> get props => [step];
}

class ChangeSelectedRadio extends VerificationEvent {
  final int selectedRadio;
  const ChangeSelectedRadio(this.selectedRadio);

  @override
  List<Object> get props => [selectedRadio];
}

class ChangeTypeIndetificationDocument extends VerificationEvent {
  final TypeIndetificationDocument type;

  const ChangeTypeIndetificationDocument(this.type);

  @override
  List<Object> get props => [type];
}

class UploadFrontCardFile extends VerificationEvent {
  final File file;
  final bool typeImage;

  const UploadFrontCardFile(this.file, this.typeImage);

  @override
  List<Object> get props => [file, typeImage];
}

class UploadBackCardFile extends VerificationEvent {
  final File file;
  final bool typeImage;

  const UploadBackCardFile(this.file, this.typeImage);

  @override
  List<Object> get props => [file, typeImage];
}

class UploadPortrait extends VerificationEvent {
  final File file;

  const UploadPortrait(this.file);

  @override
  List<Object> get props => [file];
}

class ChangeIssueBy extends VerificationEvent {
  final String issuedBy;

  const ChangeIssueBy(this.issuedBy);

  @override
  List<Object> get props => [issuedBy];
}

class ChangeGender extends VerificationEvent {
  final bool isMale;

  const ChangeGender(this.isMale);

  @override
  List<Object> get props => [isMale];
}

class ChangeApprove extends VerificationEvent {
  final bool isApprove;

  const ChangeApprove(this.isApprove);

  @override
  List<Object> get props => [isApprove];
}
