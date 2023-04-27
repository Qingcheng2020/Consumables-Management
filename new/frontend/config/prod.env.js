'use strict'

const mode = process.argv.slice(2)[0];

// 临沂市河东区妇幼保健院-二级库
let BASE_API = '"http://121.4.95.202:8070"';

// 一级库
if (mode === 'mode1') {
  BASE_API = '"http://121.4.95.202:8090"';
}

//演示系统-中国人民医院服务器
if (mode === 'mode3') {
  BASE_API = '"http://101.35.138.224:8070"';
}

//临沂市河东区妇幼保健院服务器
if (mode === 'mode4') {
  BASE_API = '"http://121.5.206.69:8070"';
}

//临沭县妇幼保健院服务器
if (mode === 'mode5') {
  BASE_API = '"http://82.157.47.64:8070"';
}

//临沭县临沭街道卫生院服务器
if (mode === 'mode6') {
  BASE_API = '"http://150.158.86.219:8070"';
}

module.exports = {
  NODE_ENV: '"production"',
  BASE_API
}
