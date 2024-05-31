abstract class AppRoutes {
  // splashScreen
  static const splash = '/splash';

  // error
  static const error = '/error';

  // login
  static const login = '/login';
  static const register = '/login/register';
  static const updateInfo = '/login/register/updateInfo';
  static const fogot = '/login/forgot';
  static const resetPassword = '/login/forgot/resetPassword';

  // bottom bar
  static const bottomBar = '/bottomBar';

  // home
  static const home = '/home';

  // blog
  static const blog = '/blog';
  // post detail
  static const blogDetail = '/blog/:id';
  static String getBlogRoute(String id) {
    return '/blog/$id';
  }

  // contract
  static const request = '/request';

  static const requestSentTab = '/request/tab/sent';
  static const requestReceivedTab = '/request/tab/received';

  static const createRequest = '/contract/createRequest';
  // request detail
  static const requestDetail = '/request/detail/:id';
  static String getRequestDetailRoute(String id) {
    return '/request/detail/$id';
  }

  static const bank = '/bank';
  static const bankList = '/bank/bankList';
  static const addBankCard = '/bank/addBankCard';

  static const changeUser = '/changeUser';

  static const contract = '/contract';

  static const contractDetail = '/contract/detail/:id';
  static String getContractDetailRoute(String id) {
    return '/contract/detail/$id';
  }

  // post detail
  static const postDetail = '/post/detail/:id';
  static String getPostRoute(String id) {
    return '/post/detail/$id';
  }

  // search
  static const search = '/search';

  // setting
  static const setting = '/setting';

  // account
  static const account = '/account';
  static const purchase = '/account/purchase';
  static const purchaseChoosePlan = '/account/purchase/choose_plan';

  // post
  static const post = '/post';

  // create post
  static const createPost = '/createPost';

  // notifications
  static const notifications = '/notifications';

  // post management
  static const postManagement = '/postManagement';

  // user profile
  static const userProfile = '/userProfile/:id';
  static String getUserProfileRoute(String id) {
    return '/userProfile/$id';
  }

  // chat
  static const chat = '/chat';
  static const chatDetail = '/chat/:id';
  static String getChatDetailRoute(String id) {
    return '/chat/$id';
  }

  // QR Code
  static const generateQRCode = '/generateQRCode';
  static const scanQRCode = '/scanQRCode';

  // chat bot
  static const chatBot = '/chatBot';

  // call video
  static const loginCall = '/loginCall';
  static const connectCall = '/connectCall';
  static const callVideo = '/callVideo';
}
