part of 'verification_bloc.dart';

enum UploadCardStatus { loading, success, failure }

enum UploadPortraittatus { loading, success, failure }

enum UploadInfoStatus { loading, success, failure }

final class VerificationState extends Equatable {
  final UploadCardStatus uploadCardStatus;
  final UploadPortraittatus uploadPortraittatus;
  final UploadInfoStatus uploadInfoStatus;

  final int activeStep;
  final int selectedRadio;

  final String urlImageCardFront;
  final String urlImageCardBack;
  final bool isUploadCardFront;
  final bool isUploadCardBack;

  final String urlImagePortrait;

  final TypeIndetificationDocument typeIndetificationDocument;
  final String issuedBy;
  final bool isMale;

  final bool isApprove;

  const VerificationState({
    this.uploadCardStatus = UploadCardStatus.loading,
    this.uploadPortraittatus = UploadPortraittatus.loading,
    this.uploadInfoStatus = UploadInfoStatus.loading,
    this.activeStep = 0,
    this.selectedRadio = 0,
    this.urlImageCardFront = "",
    this.urlImageCardBack = "",
    this.isUploadCardFront = false,
    this.isUploadCardBack = false,
    this.urlImagePortrait = "",
    this.typeIndetificationDocument = TypeIndetificationDocument.canCuocCongDan,
    this.issuedBy = "",
    this.isMale = true,
    this.isApprove = false,
  });

  VerificationState copyWith({
    UploadCardStatus? uploadCardStatus,
    UploadPortraittatus? uploadPortraittatus,
    UploadInfoStatus? uploadInfoStatus,
    int? activeStep,
    int? selectedRadio,
    String? urlImageCardFront,
    String? urlImageCardBack,
    bool? isUploadCardFront,
    bool? isUploadCardBack,
    String? urlImagePortrait,
    TypeIndetificationDocument? typeIndetificationDocument,
    String? issuedBy,
    bool? isMale,
    bool? isApprove,
  }) {
    return VerificationState(
      uploadCardStatus: uploadCardStatus ?? this.uploadCardStatus,
      uploadPortraittatus: uploadPortraittatus ?? this.uploadPortraittatus,
      uploadInfoStatus: uploadInfoStatus ?? this.uploadInfoStatus,
      activeStep: activeStep ?? this.activeStep,
      selectedRadio: selectedRadio ?? this.selectedRadio,
      urlImageCardFront: urlImageCardFront ?? this.urlImageCardFront,
      urlImageCardBack: urlImageCardBack ?? this.urlImageCardBack,
      isUploadCardFront: isUploadCardFront ?? this.isUploadCardFront,
      isUploadCardBack: isUploadCardBack ?? this.isUploadCardBack,
      urlImagePortrait: urlImagePortrait ?? this.urlImagePortrait,
      typeIndetificationDocument:
          typeIndetificationDocument ?? this.typeIndetificationDocument,
      issuedBy: issuedBy ?? this.issuedBy,
      isMale: isMale ?? this.isMale,
      isApprove: isApprove ?? this.isApprove,
    );
  }

  @override
  List<Object> get props => [
        uploadCardStatus,
        uploadPortraittatus,
        uploadInfoStatus,
        activeStep,
        selectedRadio,
        urlImageCardFront,
        urlImageCardBack,
        isUploadCardFront,
        isUploadCardBack,
        urlImagePortrait,
        typeIndetificationDocument,
        issuedBy,
        isMale,
        isApprove,
      ];
}
