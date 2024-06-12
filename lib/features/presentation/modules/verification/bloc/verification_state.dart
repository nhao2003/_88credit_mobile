part of 'verification_bloc.dart';

enum InitEkycStatus { init, loading, success, failure }

enum UploadCardFrontStatus { init, loading, success, failure }

enum UploadCardBackStatus { init, loading, success, failure }

enum UploadPortraitstatus { init, loading, success, failure }

enum UploadInfoStatus { init, loading, success, failure }

final class VerificationState extends Equatable {
  final InitEkycStatus initEkycStatus;
  final UploadCardFrontStatus uploadCardFrontStatus;
  final UploadCardBackStatus uploadCardBackStatus;
  final UploadPortraitstatus uploadPortraitstatus;
  final UploadInfoStatus uploadInfoStatus;

  final String requestId;
  final FrontCardInfo frontCardInfo;
  final BackCardInfo backCardInfo;

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
    this.initEkycStatus = InitEkycStatus.init,
    this.uploadCardFrontStatus = UploadCardFrontStatus.init,
    this.uploadCardBackStatus = UploadCardBackStatus.init,
    this.uploadPortraitstatus = UploadPortraitstatus.init,
    this.uploadInfoStatus = UploadInfoStatus.init,
    this.requestId = "",
    this.frontCardInfo = const FrontCardInfo(),
    this.backCardInfo = const BackCardInfo(),
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
    UploadCardFrontStatus? uploadCardFrontStatus,
    UploadCardBackStatus? uploadCardBackStatus,
    UploadPortraitstatus? uploadPortraitstatus,
    UploadInfoStatus? uploadInfoStatus,
    String? requestId,
    FrontCardInfo? frontCardInfo,
    BackCardInfo? backCardInfo,
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
      uploadCardFrontStatus:
          uploadCardFrontStatus ?? this.uploadCardFrontStatus,
      uploadCardBackStatus: uploadCardBackStatus ?? this.uploadCardBackStatus,
      uploadPortraitstatus: uploadPortraitstatus ?? this.uploadPortraitstatus,
      uploadInfoStatus: uploadInfoStatus ?? this.uploadInfoStatus,
      requestId: requestId ?? this.requestId,
      frontCardInfo: frontCardInfo ?? this.frontCardInfo,
      backCardInfo: backCardInfo ?? this.backCardInfo,
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

  const VerificationState.init()
      : initEkycStatus = InitEkycStatus.init,
        uploadCardFrontStatus = UploadCardFrontStatus.init,
        uploadCardBackStatus = UploadCardBackStatus.init,
        uploadPortraitstatus = UploadPortraitstatus.init,
        uploadInfoStatus = UploadInfoStatus.init,
        requestId = "",
        frontCardInfo = const FrontCardInfo(),
        backCardInfo = const BackCardInfo(),
        activeStep = 0,
        selectedRadio = 0,
        urlImageCardFront = "",
        urlImageCardBack = "",
        isUploadCardFront = false,
        isUploadCardBack = false,
        urlImagePortrait = "",
        typeIndetificationDocument = TypeIndetificationDocument.canCuocCongDan,
        issuedBy = "",
        isMale = true,
        isApprove = false;

  @override
  List<Object> get props => [
        initEkycStatus,
        uploadCardFrontStatus,
        uploadCardBackStatus,
        frontCardInfo,
        backCardInfo,
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
