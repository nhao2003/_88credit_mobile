part of 'verification_bloc.dart';

enum InitEkycStatus { loading, success, failure }

enum UploadCardStatus { loading, success, failure }

enum UploadPortraitstatus { loading, success, failure }

enum UploadInfoStatus { loading, success, failure }

final class VerificationState extends Equatable {
  final InitEkycStatus initEkycStatus;
  final UploadCardStatus uploadCardStatus;
  final UploadPortraitstatus uploadPortraitstatus;
  final UploadInfoStatus uploadInfoStatus;

  final String requestId;

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
    this.initEkycStatus = InitEkycStatus.loading,
    this.uploadCardStatus = UploadCardStatus.loading,
    this.uploadPortraitstatus = UploadPortraitstatus.loading,
    this.uploadInfoStatus = UploadInfoStatus.loading,
    this.requestId = "",
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
    InitEkycStatus? initEkycStatus,
    UploadCardStatus? uploadCardStatus,
    UploadPortraitstatus? uploadPortraitstatus,
    UploadInfoStatus? uploadInfoStatus,
    String? requestId,
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
      initEkycStatus: initEkycStatus ?? this.initEkycStatus,
      uploadCardStatus: uploadCardStatus ?? this.uploadCardStatus,
      uploadPortraitstatus: uploadPortraitstatus ?? this.uploadPortraitstatus,
      uploadInfoStatus: uploadInfoStatus ?? this.uploadInfoStatus,
      requestId: requestId ?? this.requestId,
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
        initEkycStatus,
        uploadCardStatus,
        uploadPortraitstatus,
        uploadInfoStatus,
        requestId,
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
