const ipLocal = "172.17.14.167";
const ipMobile = "";
const isIPMobile = false;
const ipConfig = isIPMobile ? ipMobile : ipLocal;

const String apiDevUrl = "http://$ipConfig:8080";
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
const String kCreateRequestEndpoint = '/loan-request';
const String kPayLoanRequestEndpoint = '/loan-request/lender-pay';
const String kConfirmRequestEndpoint = '/loan-request/lender-accept';
const String kRejectRequestEndpoint = '/loan-request/reject-request';

const String kGetUserEndpoint = '/user';

const String kGetContractEndpoint = '/contract';
const String kGetMe = '/user/me';

const String kGetBankEndpoint = '/bank';
const String kGetBankCardEndpoint = '/bank-card';
const String kGetPrimaryBankCardEndpoint = '/bank-card/primary';
const String kGetMarkPrimaryEndpoint = '/bank-card/:id/primary';
