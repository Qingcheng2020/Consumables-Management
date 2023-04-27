module.exports = {
  title: 'LEAN HMS', // 'Vue Element Admin',

  /**
   * @type {boolean} true | false
   * @description Whether show the settings right-panel
   */
  showSettings: true,

  /**
   * @type {boolean} true | false
   * @description Whether need tagsView
   */
  tagsView: true,

  /**
   * @type {boolean} true | false
   * @description Whether fix the header
   */
  fixedHeader: false,

  /**
   * @type {boolean} true | false
   * @description Whether show the logo in sidebar
   */
  sidebarLogo: false,

  /**
   * @type {string | array} 'production' | ['production', 'development']
   * @description Need show err logs component.
   * The default is only used in the production env
   * If you want to also use it in dev, you can pass ['production', 'development']
   */
  errorLog: 'production',

  //本地服务器
  /*preUploadUrl: 'http://localhost:8070/preInBill/upload',
  baseInfoUploadUrl: 'http://localhost:8070/baseInfo/upload',
  qualificationUploadUrl: 'http://localhost:8070/qualification/upload',*/

  //121服务器
  /*  preUploadUrl: 'http://121.4.95.202:8070/preInBill/upload',
    baseInfoUploadUrl: 'http://121.4.95.202:8070/baseInfo/upload',
    qualificationUploadUrl: 'http://121.4.95.2024:8070/qualification/upload',*/

  //临沂市河东区妇幼保健院
/*  preUploadUrl: 'http://121.5.206.69:8070/preInBill/upload',
  baseInfoUploadUrl: 'http://121.5.206.69:8070/baseInfo/upload',
  qualificationUploadUrl: 'http://121.5.206.69:8070/qualification/upload',*/

    //临沭县妇幼保健院
/*    preUploadUrl: 'http://82.157.47.64:8070/preInBill/upload',
    baseInfoUploadUrl: 'http://82.157.47.64:8070/baseInfo/upload',
    qualificationUploadUrl: 'http://82.157.47.64:8070/qualification/upload',*/

    //临沭县临沭街道卫生院
/*    preUploadUrl: 'http://150.158.86.219:8070/preInBill/upload',
    baseInfoUploadUrl: 'http://150.158.86.219:8070/baseInfo/upload',
    qualificationUploadUrl: 'http://150.158.86.219:8070/qualification/upload',*/

    //测试服务器
    preUploadUrl: 'http://101.35.138.224:8070/preInBill/upload',
    baseInfoUploadUrl: 'http://101.35.138.224:8070/baseInfo/upload',
    qualificationUploadUrl: 'http://101.35.138.224:8070/qualification/upload',

  // 本地 action="http://localhost:8070/qualification/upload"
  // 二级 action="http://121.4.95.202:8070/qualification/upload"
  // 一级 action="http://121.4.95.202:8090/qualification/upload"
  // 演示二级 action="http://101.35.138.224:8070/qualification/upload"
}
