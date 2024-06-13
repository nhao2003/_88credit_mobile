const ipMobile = "192.168.221.225";
const ipLocal = "192.168.91.53";
const isIPMobile = false;
const ipConfig = isIPMobile ? ipMobile : ipLocal;

const String apiDevUrl = "http://$ipConfig";
const String apiProductionUrl = "https://eight8credit.onrender.com";
const bool isProduction = false;
const String apiUrl = isProduction ? apiProductionUrl : apiDevUrl;
// http://localhost:8080/auth/sign-in

const String envPath = "assets/.env";
//const String apiAppUrl = isProduction ? apiProductionUrl : apiDevUrl;
const String kSignIn = '/auth/sign-in';
const String kSignUp = '/auth/sign-up';
const String kChangePassword = '/auth/change-password';
const String kSignOut = '/auth/sign-out';
const String kSignOutAll = '/auth/sign-out-all';
const String kActiveAccount = '/auth/active-account';
const String kResendActivationCode = '/auth/resend-activation-code';
const String kRefreshToken = '/auth/refresh-token';

const String kGetPostEndpoint = '/post';
const String kCreatePostEndpoint = '/post';
const String kGetMembershipPackageEndpoint = '/membership-package';
const String kGetTransactionEndpoint = '/membership-package/transactions';
const String kCreateOrderEndpoint = '/membership-package/check-out';
const String kGetBlogEndpoint = '/blog';

const String kGetRequestEndpoint = '/loan-request';
const String kPayLoanRequestEndpoint = '/pay';
const String kCreateRequestEndpoint = '/loan-request';
const String kConfirmRequestEndpoint = '/approve';
const String kRejectRequestEndpoint = '/reject';
const String kMarkPaidRequestEndpoint = '/mark-paid';
const String kCancelRequestEndpoint = '/cancel';

const String kGetUserEndpoint = '/user';

const String kGetContractEndpoint = '/loan-contract';
const String kGetMe = '/user/me';

const String kGetBankEndpoint = '/bank';
const String kGetBankCardEndpoint = '/bank-card';
const String kGetPrimaryBankCardEndpoint = '/bank-card/primary';
const String kGetMarkPrimaryEndpoint = '/primary';

const String kUploadMediaEndpoint = '/storage/upload';

const String kInitEkycEndpoint = '/ekyc/request';
const String kOrcFrontEndpoint = '/ekyc/ocr/front-image';
const String kOrcBackEndpoint = '/ekyc/ocr/back-image';
const String kFaceEndpoint = '/ekyc/face';
const String kAddFaceEndpoint = '/add-face';
const String kSubmitRequestEndpoint = '/ekyc/request/submit';

const minMoney = 1000;
const maxMoney = 1000000000;
const minInterestRate = 0.1;
const maxInterestRate = 1.66;
const minTenureMonths = 1;
const maxTenureMonths = 24;
