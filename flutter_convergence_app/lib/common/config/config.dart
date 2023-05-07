class Config {
  static const bool DEBUG = true;
  static const PAGE_SIZE = 20;
  static const TOKEN_KEY = "token";
  static const USER_INFO = "userInfo";
  static const USER_VIP = "vipLevel";

// 默认账号 135 54 75 7224 0000

  //api请求地址
  static const String baseURL = "https://rhyzapi.rongheyouzu.com";

  //埋点
  static const String addEventUrl = "/record/event/addEvent";
  // 登录
  // static const String loginUrl = "/rhyzadmin/app/appuser/loginNoRegister";
  static const String loginUrl = "/rhyzadmin/app/appuser/loginBySmsCode";

  static const String appSmsCode = "/rhyzadmin/app/appuser/appSmsCode";

  //首页贷款列表-特别推荐
  static const String homeBankUrl = "/rhyzadmin/app/product/getJqbList";

  //首页今日推荐
  static const String todayRecommed =
      "/rhyzadmin/app/product/getNewTodayRecommed";
  //新口子推荐
  static const String productRecommed = "/rhyzadmin/app/product/getJqbList";
  //用户信息
  static const String userInfo = "/rhyzadmin/app/appuser/getAppUserInfo";
  // 实名制信息认证
  static const String userRealCheck = "/rhyzadmin/app/appuser/userRealCheck";

  //获取产品地址
  static const String productUr = "/rhyzadmin/app/product/getProductUrlById";

  //支付
  static const String payVip = "/rhyzadmin//app/appuser/payVip";
  // 支付的-appid2021002194675872

  //获取权益
  static const String getAppShowConfig =
      "/rhyzadmin/app/appconfig/getAppShowConfig";

  //获取会员专享
  static const String getVipProductList =
      "/rhyzadmin/app/product/getVipProductList";

  // 上传图片--需要
  static const String uploadFileToOssFront =
      "/wwqbAdmin/base/idcardCheck"; //正面--需要
  static const String uploadFileToOssBack =
      "/wwqbAdmin/base/uploadFileToOss"; //背面--需要

  //现金贷接口路径
  // 基本信息认证
  static const String basicInfoUrl = "/wwqbAdmin/loanapp/user/basicInfoVerify";
  // 获得用户验证信息
  static const String getAuthInfoUrl =
      "/wwqbAdmin/loanapp/user/getLoanUserVerifyInfo";
  // 发送短信验证码
  static const String xjdSendSmsCodeUrl =
      "/wwqbAdmin/app/appuser/appSmsCode"; //需要
  // 运营商认证
  static const String operatorAuthUrl =
      "/wwqbAdmin/loanapp/user/phoneOperatorsVerity";
  // 上传实名认证信息
  static const String xjdSaveRealInfoUrl =
      "/wwqbAdmin/app/appuser/saveRealInfo"; //需要

  // 获取用户信息
  static const String userinfo = "/wwqbAdmin/app/appuser/getAppUserInfo"; //需要
  // 获取用户借款记录
  static const String loanRecord = "/wwqbAdmin/loanapp/app/getXdjUserLoanInfo";
  // 添加记录
  static const String record = "/wwqbAdmin/loanapp/app/insertRecord";
  // 获取所关联的客服信息
  static const String friendIdByPhoneNum =
      "/wwqbAdmin/loanapp/app/getFriendIdByPhoneNum";
  // 获取支付二维码
  static const String payLink = "/wwqbAdmin/app/appconfig/getPayType";
  // 获取借款详情
  static const String loanDetail = "/wwqbAdmin/loanapp/app/getLoanDetail";
  // 查看用户认证信息
  static const String basicInfo2 = "/wwqbAdmin/loanapp/user/getBasicInfo";
  // 贷款大全列表
  static const String getJqbListUrl = "/wwqbAdmin/app/product/getJqbList";
  // 获取今日推荐区域数据
  static const String getTodayRecommedUrl =
      "/wwqbAdmin/app/product/getNewTodayRecommed";
  // 获取审核状态
  static const String getApprovalStatusUrl =
      "/wwqbAdmin/app/appuser/getUserStatus";

  // 新增投诉信息
  static const String addComplaintUrl = "/wwqbAdmin/app/appuser/addComplaint";

  // 判断用户是否可以弹窗
  static const String isShowDialogUrl = "/wwqbAdmin/app/product/getUserWindown";
  // 获取弹窗产品
  static const String getDialogProdUrl =
      "/wwqbAdmin/app/product/getWindowProductNew";


  /*判断使用那个每次Stages */
  static Map dict = {
    "name": "融合优租" ,
    "privacyUrl":  "https://yinsi.rongheyouzu.com/",
    "agreementUrl":"https://welcome.rongheyouzu.com/",
    "authorizationUrl": "http://shouquan.rongheyouzu.com/",
    "noticeUrl": "http://gaozhishu.rongheyouzu.com/"
  };
}
