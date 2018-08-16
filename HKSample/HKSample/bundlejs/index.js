// { "framework": "Vue"} 

/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 3);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */,
/* 1 */,
/* 2 */,
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var _index = __webpack_require__(4);

var _index2 = _interopRequireDefault(_index);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

_index2.default.el = '#root';
new Vue(_index2.default);

/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

var __vue_exports__, __vue_options__
var __vue_styles__ = []

/* styles */
__vue_styles__.push(__webpack_require__(5)
)

/* script */
__vue_exports__ = __webpack_require__(6)

/* template */
var __vue_template__ = __webpack_require__(7)
__vue_options__ = __vue_exports__ = __vue_exports__ || {}
if (
  typeof __vue_exports__.default === "object" ||
  typeof __vue_exports__.default === "function"
) {
if (Object.keys(__vue_exports__).some(function (key) { return key !== "default" && key !== "__esModule" })) {console.error("named exports are not supported in *.vue files.")}
__vue_options__ = __vue_exports__ = __vue_exports__.default
}
if (typeof __vue_options__ === "function") {
  __vue_options__ = __vue_options__.options
}
__vue_options__.__file = "/Users/yangzhi/Desktop/weex/awesome-app/src/index.vue"
__vue_options__.render = __vue_template__.render
__vue_options__.staticRenderFns = __vue_template__.staticRenderFns
__vue_options__._scopeId = "data-v-2964abc9"
__vue_options__.style = __vue_options__.style || {}
__vue_styles__.forEach(function (module) {
  for (var name in module) {
    __vue_options__.style[name] = module[name]
  }
})
if (typeof __register_static_styles__ === "function") {
  __register_static_styles__(__vue_options__._scopeId, __vue_styles__)
}

module.exports = __vue_exports__


/***/ }),
/* 5 */
/***/ (function(module, exports) {

module.exports = {
  "wrapper": {
    "backgroundColor": "#F8F8F8"
  },
  "container-title": {
    "backgroundColor": "#FFFFFF",
    "width": "750",
    "height": "203"
  },
  "title": {
    "height": "100",
    "lineHeight": "100",
    "marginTop": "18",
    "marginLeft": "22",
    "fontSize": "64",
    "fontFamily": "PingFangSC-Regular",
    "color": "#333333"
  },
  "desc": {
    "marginTop": "42",
    "marginLeft": "22",
    "fontSize": "28",
    "lineHeight": "28",
    "fontFamily": "PingFangSC-Regular",
    "color": "#333333"
  },
  "container-inner": {
    "backgroundColor": "#FFFFFF",
    "flexDirection": "row",
    "flexWrap": "wrap"
  },
  "container-photo": {
    "height": "303",
    "width": "225",
    "marginLeft": "19",
    "backgroundColor": "#FFFFFF"
  },
  "img": {
    "backgroundColor": "#FFFFFF",
    "marginTop": "25",
    "width": "210",
    "height": "210",
    "borderRadius": "12",
    "color": "#FFFFFF"
  },
  "delete-image": {
    "position": "absolute",
    "right": 0,
    "top": 0,
    "width": "50",
    "height": "50"
  },
  "position": {
    "height": "68",
    "width": "210",
    "lineHeight": "68",
    "fontSize": "28",
    "textAlign": "center",
    "color": "#D1D1D1"
  },
  "feedback": {
    "width": "750",
    "height": "160",
    "marginTop": "20",
    "paddingTop": "10",
    "paddingLeft": "22",
    "paddingRight": "22",
    "paddingBottom": "10",
    "fontSize": "28",
    "backgroundColor": "#FFFFFF"
  }
}

/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

exports.default = {
  data: function data() {
    return {
      isChoosePhoto: false,
      feedback: '',
      data: [{ position: '车头', photo: '' }, { position: '车左侧', photo: '' }, { position: '车右侧', photo: '' }, { position: '车尾', photo: '' }, { position: '车内室', photo: '' }, { position: '其它', photo: '' }],
      submitUnusable: {
        position: 'absolute',
        bottom: 0,
        width: '750px',
        height: '100px',
        lineHeight: '100px',
        fontSize: '32px',
        textAlign: 'center',
        color: 'white',
        backgroundColor: '#CCCCCC'
      },
      submitUsable: {
        backgroundColor: '#39424B'
      }
    };
  },

  methods: {
    submit: function submit() {
      //   网络请求
      //   weex.requireModule('hkAxios').fetch({
      //     header: {
      //       apiVersion: null
      //     },
      //     method: 'GET',
      //     url: 'http://korafile.oss-cn-beijing.aliyuncs.com/cityinfo/prod/city.json',
      //     param: {
      //       p1: 'p1',
      //       p2: 'p2'
      //     }
      //   }, success => {
      //    console.log(success);
      //  }, failure => {
      //   console.log(failure);
      // });

      // 控制器
      // var navigator = weex.requireModule('navigator')
      // navigator.setNavBarLeftItem({title: 'next'}, event => {

      // }),
      // navigator.setNavBarHidden({hidden: false}, event => {

      // }),
      // navigator.push({
      //   url: 'http://192.168.31.211:8081/dist/next.js',
      //   animated: "true"
      // }, event => {
      //   console.log(event);
      // })

      weex.requireModule('hkRouter').open({
        url: 'next',
        type: 'PUSH',
        params: 'params--1',
        pageName: 'index'
      }, function (resData) {
        console.log('回调成功');
      });

      // weex.requireModule("hkOrderProblemReporting").submit(this.feedback, this.data);
    },
    checkSubmitState: function checkSubmitState() {
      this.isChoosePhoto = false;

      for (var index in this.data) {
        if (this.data[index].photo.length > 0) this.isChoosePhoto = true;
      }

      if (this.feedback.length > 0) this.isChoosePhoto = true;
    },
    feedbackOnchange: function feedbackOnchange(event) {
      this.feedback = event.value;
      this.checkSubmitState();
      console.log("this.feedback = " + this.feedback + "-----------------------" + "this.isChoosePhoto = " + this.isChoosePhoto);
    },
    takephoto: function takephoto(index) {
      var _this = this;

      weex.requireModule("hkImage").camera({
        imageWidth: '800',
        allowCrop: true
      }, function (resData) {
        _this.data[index].photo = resData.data[0];
        _this.checkSubmitState();
      });
    },
    deletephoto: function deletephoto(index) {
      this.data[index].photo = '';
      this.checkSubmitState();
    }
  }
};

/***/ }),
/* 7 */
/***/ (function(module, exports) {

module.exports={render:function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', {
    staticClass: ["wrapper"]
  }, [_vm._m(0), _c('div', {
    staticClass: ["container-inner"]
  }, _vm._l((_vm.data), function(item, index) {
    return _c('div', {
      staticClass: ["container-photo"]
    }, [_c('image', {
      staticClass: ["img"],
      attrs: {
        "src": item.photo,
        "placeholder": "local:///photo_placeholder.png"
      },
      on: {
        "click": function($event) {
          _vm.takephoto(index)
        }
      }
    }), _c('text', {
      staticClass: ["position"]
    }, [_vm._v(_vm._s(item.position))]), (item.photo) ? _c('image', {
      staticClass: ["delete-image"],
      attrs: {
        "resize": "contain",
        "src": "local:///delete_photo.png"
      },
      on: {
        "click": function($event) {
          _vm.deletephoto(index)
        }
      }
    }) : _vm._e()])
  })), _c('textarea', {
    staticClass: ["feedback"],
    attrs: {
      "rows": "5",
      "placeholder": "请描述车辆问题，帮助我们更好的提高服务，请在500字以内"
    },
    on: {
      "change": _vm.feedbackOnchange
    }
  }), (_vm.isChoosePhoto) ? _c('text', {
    style: [_vm.submitUnusable, _vm.submitUsable],
    on: {
      "click": _vm.submit
    }
  }, [_vm._v("提交")]) : _vm._e(), (!_vm.isChoosePhoto) ? _c('text', {
    style: _vm.submitUnusable,
    on: {
      "click": _vm.submit
    }
  }, [_vm._v("提交")]) : _vm._e()])
},staticRenderFns: [function (){var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;
  return _c('div', {
    staticClass: ["container-title"]
  }, [_c('text', {
    staticClass: ["title"]
  }, [_vm._v("车况上报")]), _c('text', {
    staticClass: ["desc"]
  }, [_vm._v("如果发现车辆问题，请上传对应图片")])])
}]}
module.exports.render._withStripped = true

/***/ })
/******/ ]);