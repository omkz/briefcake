(() => {
  var __require = /* @__PURE__ */ ((x) => typeof require !== "undefined" ? require : typeof Proxy !== "undefined" ? new Proxy(x, {
    get: (a, b) => (typeof require !== "undefined" ? require : a)[b]
  }) : x)(function(x) {
    if (typeof require !== "undefined")
      return require.apply(this, arguments);
    throw new Error('Dynamic require of "' + x + '" is not supported');
  });
  var __commonJS = (cb, mod) => function __require2() {
    return mod || (0, cb[Object.keys(cb)[0]])((mod = { exports: {} }).exports, mod), mod.exports;
  };

  // ../../node_modules/@rails/ujs/lib/assets/compiled/rails-ujs.js
  var require_rails_ujs = __commonJS({
    "../../node_modules/@rails/ujs/lib/assets/compiled/rails-ujs.js"(exports, module) {
      (function() {
        var context2 = this;
        (function() {
          (function() {
            this.Rails = {
              linkClickSelector: "a[data-confirm], a[data-method], a[data-remote]:not([disabled]), a[data-disable-with], a[data-disable]",
              buttonClickSelector: {
                selector: "button[data-remote]:not([form]), button[data-confirm]:not([form])",
                exclude: "form button"
              },
              inputChangeSelector: "select[data-remote], input[data-remote], textarea[data-remote]",
              formSubmitSelector: "form",
              formInputClickSelector: "form input[type=submit], form input[type=image], form button[type=submit], form button:not([type]), input[type=submit][form], input[type=image][form], button[type=submit][form], button[form]:not([type])",
              formDisableSelector: "input[data-disable-with]:enabled, button[data-disable-with]:enabled, textarea[data-disable-with]:enabled, input[data-disable]:enabled, button[data-disable]:enabled, textarea[data-disable]:enabled",
              formEnableSelector: "input[data-disable-with]:disabled, button[data-disable-with]:disabled, textarea[data-disable-with]:disabled, input[data-disable]:disabled, button[data-disable]:disabled, textarea[data-disable]:disabled",
              fileInputSelector: "input[name][type=file]:not([disabled])",
              linkDisableSelector: "a[data-disable-with], a[data-disable]",
              buttonDisableSelector: "button[data-remote][data-disable-with], button[data-remote][data-disable]"
            };
          }).call(this);
        }).call(context2);
        var Rails = context2.Rails;
        (function() {
          (function() {
            var nonce;
            nonce = null;
            Rails.loadCSPNonce = function() {
              var ref;
              return nonce = (ref = document.querySelector("meta[name=csp-nonce]")) != null ? ref.content : void 0;
            };
            Rails.cspNonce = function() {
              return nonce != null ? nonce : Rails.loadCSPNonce();
            };
          }).call(this);
          (function() {
            var expando, m;
            m = Element.prototype.matches || Element.prototype.matchesSelector || Element.prototype.mozMatchesSelector || Element.prototype.msMatchesSelector || Element.prototype.oMatchesSelector || Element.prototype.webkitMatchesSelector;
            Rails.matches = function(element, selector) {
              if (selector.exclude != null) {
                return m.call(element, selector.selector) && !m.call(element, selector.exclude);
              } else {
                return m.call(element, selector);
              }
            };
            expando = "_ujsData";
            Rails.getData = function(element, key) {
              var ref;
              return (ref = element[expando]) != null ? ref[key] : void 0;
            };
            Rails.setData = function(element, key, value) {
              if (element[expando] == null) {
                element[expando] = {};
              }
              return element[expando][key] = value;
            };
            Rails.$ = function(selector) {
              return Array.prototype.slice.call(document.querySelectorAll(selector));
            };
          }).call(this);
          (function() {
            var $, csrfParam, csrfToken;
            $ = Rails.$;
            csrfToken = Rails.csrfToken = function() {
              var meta;
              meta = document.querySelector("meta[name=csrf-token]");
              return meta && meta.content;
            };
            csrfParam = Rails.csrfParam = function() {
              var meta;
              meta = document.querySelector("meta[name=csrf-param]");
              return meta && meta.content;
            };
            Rails.CSRFProtection = function(xhr) {
              var token;
              token = csrfToken();
              if (token != null) {
                return xhr.setRequestHeader("X-CSRF-Token", token);
              }
            };
            Rails.refreshCSRFTokens = function() {
              var param, token;
              token = csrfToken();
              param = csrfParam();
              if (token != null && param != null) {
                return $('form input[name="' + param + '"]').forEach(function(input) {
                  return input.value = token;
                });
              }
            };
          }).call(this);
          (function() {
            var CustomEvent, fire, matches, preventDefault;
            matches = Rails.matches;
            CustomEvent = window.CustomEvent;
            if (typeof CustomEvent !== "function") {
              CustomEvent = function(event, params) {
                var evt;
                evt = document.createEvent("CustomEvent");
                evt.initCustomEvent(event, params.bubbles, params.cancelable, params.detail);
                return evt;
              };
              CustomEvent.prototype = window.Event.prototype;
              preventDefault = CustomEvent.prototype.preventDefault;
              CustomEvent.prototype.preventDefault = function() {
                var result;
                result = preventDefault.call(this);
                if (this.cancelable && !this.defaultPrevented) {
                  Object.defineProperty(this, "defaultPrevented", {
                    get: function() {
                      return true;
                    }
                  });
                }
                return result;
              };
            }
            fire = Rails.fire = function(obj, name, data) {
              var event;
              event = new CustomEvent(name, {
                bubbles: true,
                cancelable: true,
                detail: data
              });
              obj.dispatchEvent(event);
              return !event.defaultPrevented;
            };
            Rails.stopEverything = function(e) {
              fire(e.target, "ujs:everythingStopped");
              e.preventDefault();
              e.stopPropagation();
              return e.stopImmediatePropagation();
            };
            Rails.delegate = function(element, selector, eventType, handler) {
              return element.addEventListener(eventType, function(e) {
                var target;
                target = e.target;
                while (!(!(target instanceof Element) || matches(target, selector))) {
                  target = target.parentNode;
                }
                if (target instanceof Element && handler.call(target, e) === false) {
                  e.preventDefault();
                  return e.stopPropagation();
                }
              });
            };
          }).call(this);
          (function() {
            var AcceptHeaders, CSRFProtection, createXHR, cspNonce, fire, prepareOptions, processResponse;
            cspNonce = Rails.cspNonce, CSRFProtection = Rails.CSRFProtection, fire = Rails.fire;
            AcceptHeaders = {
              "*": "*/*",
              text: "text/plain",
              html: "text/html",
              xml: "application/xml, text/xml",
              json: "application/json, text/javascript",
              script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"
            };
            Rails.ajax = function(options) {
              var xhr;
              options = prepareOptions(options);
              xhr = createXHR(options, function() {
                var ref, response;
                response = processResponse((ref = xhr.response) != null ? ref : xhr.responseText, xhr.getResponseHeader("Content-Type"));
                if (Math.floor(xhr.status / 100) === 2) {
                  if (typeof options.success === "function") {
                    options.success(response, xhr.statusText, xhr);
                  }
                } else {
                  if (typeof options.error === "function") {
                    options.error(response, xhr.statusText, xhr);
                  }
                }
                return typeof options.complete === "function" ? options.complete(xhr, xhr.statusText) : void 0;
              });
              if (options.beforeSend != null && !options.beforeSend(xhr, options)) {
                return false;
              }
              if (xhr.readyState === XMLHttpRequest.OPENED) {
                return xhr.send(options.data);
              }
            };
            prepareOptions = function(options) {
              options.url = options.url || location.href;
              options.type = options.type.toUpperCase();
              if (options.type === "GET" && options.data) {
                if (options.url.indexOf("?") < 0) {
                  options.url += "?" + options.data;
                } else {
                  options.url += "&" + options.data;
                }
              }
              if (AcceptHeaders[options.dataType] == null) {
                options.dataType = "*";
              }
              options.accept = AcceptHeaders[options.dataType];
              if (options.dataType !== "*") {
                options.accept += ", */*; q=0.01";
              }
              return options;
            };
            createXHR = function(options, done) {
              var xhr;
              xhr = new XMLHttpRequest();
              xhr.open(options.type, options.url, true);
              xhr.setRequestHeader("Accept", options.accept);
              if (typeof options.data === "string") {
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
              }
              if (!options.crossDomain) {
                xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
              }
              CSRFProtection(xhr);
              xhr.withCredentials = !!options.withCredentials;
              xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                  return done(xhr);
                }
              };
              return xhr;
            };
            processResponse = function(response, type) {
              var parser, script;
              if (typeof response === "string" && typeof type === "string") {
                if (type.match(/\bjson\b/)) {
                  try {
                    response = JSON.parse(response);
                  } catch (error2) {
                  }
                } else if (type.match(/\b(?:java|ecma)script\b/)) {
                  script = document.createElement("script");
                  script.setAttribute("nonce", cspNonce());
                  script.text = response;
                  document.head.appendChild(script).parentNode.removeChild(script);
                } else if (type.match(/\b(xml|html|svg)\b/)) {
                  parser = new DOMParser();
                  type = type.replace(/;.+/, "");
                  try {
                    response = parser.parseFromString(response, type);
                  } catch (error2) {
                  }
                }
              }
              return response;
            };
            Rails.href = function(element) {
              return element.href;
            };
            Rails.isCrossDomain = function(url) {
              var e, originAnchor, urlAnchor;
              originAnchor = document.createElement("a");
              originAnchor.href = location.href;
              urlAnchor = document.createElement("a");
              try {
                urlAnchor.href = url;
                return !((!urlAnchor.protocol || urlAnchor.protocol === ":") && !urlAnchor.host || originAnchor.protocol + "//" + originAnchor.host === urlAnchor.protocol + "//" + urlAnchor.host);
              } catch (error2) {
                e = error2;
                return true;
              }
            };
          }).call(this);
          (function() {
            var matches, toArray;
            matches = Rails.matches;
            toArray = function(e) {
              return Array.prototype.slice.call(e);
            };
            Rails.serializeElement = function(element, additionalParam) {
              var inputs, params;
              inputs = [element];
              if (matches(element, "form")) {
                inputs = toArray(element.elements);
              }
              params = [];
              inputs.forEach(function(input) {
                if (!input.name || input.disabled) {
                  return;
                }
                if (matches(input, "fieldset[disabled] *")) {
                  return;
                }
                if (matches(input, "select")) {
                  return toArray(input.options).forEach(function(option) {
                    if (option.selected) {
                      return params.push({
                        name: input.name,
                        value: option.value
                      });
                    }
                  });
                } else if (input.checked || ["radio", "checkbox", "submit"].indexOf(input.type) === -1) {
                  return params.push({
                    name: input.name,
                    value: input.value
                  });
                }
              });
              if (additionalParam) {
                params.push(additionalParam);
              }
              return params.map(function(param) {
                if (param.name != null) {
                  return encodeURIComponent(param.name) + "=" + encodeURIComponent(param.value);
                } else {
                  return param;
                }
              }).join("&");
            };
            Rails.formElements = function(form, selector) {
              if (matches(form, "form")) {
                return toArray(form.elements).filter(function(el) {
                  return matches(el, selector);
                });
              } else {
                return toArray(form.querySelectorAll(selector));
              }
            };
          }).call(this);
          (function() {
            var allowAction, fire, stopEverything;
            fire = Rails.fire, stopEverything = Rails.stopEverything;
            Rails.handleConfirm = function(e) {
              if (!allowAction(this)) {
                return stopEverything(e);
              }
            };
            Rails.confirm = function(message, element) {
              return confirm(message);
            };
            allowAction = function(element) {
              var answer, callback, message;
              message = element.getAttribute("data-confirm");
              if (!message) {
                return true;
              }
              answer = false;
              if (fire(element, "confirm")) {
                try {
                  answer = Rails.confirm(message, element);
                } catch (error2) {
                }
                callback = fire(element, "confirm:complete", [answer]);
              }
              return answer && callback;
            };
          }).call(this);
          (function() {
            var disableFormElement, disableFormElements, disableLinkElement, enableFormElement, enableFormElements, enableLinkElement, formElements, getData, isXhrRedirect, matches, setData, stopEverything;
            matches = Rails.matches, getData = Rails.getData, setData = Rails.setData, stopEverything = Rails.stopEverything, formElements = Rails.formElements;
            Rails.handleDisabledElement = function(e) {
              var element;
              element = this;
              if (element.disabled) {
                return stopEverything(e);
              }
            };
            Rails.enableElement = function(e) {
              var element;
              if (e instanceof Event) {
                if (isXhrRedirect(e)) {
                  return;
                }
                element = e.target;
              } else {
                element = e;
              }
              if (matches(element, Rails.linkDisableSelector)) {
                return enableLinkElement(element);
              } else if (matches(element, Rails.buttonDisableSelector) || matches(element, Rails.formEnableSelector)) {
                return enableFormElement(element);
              } else if (matches(element, Rails.formSubmitSelector)) {
                return enableFormElements(element);
              }
            };
            Rails.disableElement = function(e) {
              var element;
              element = e instanceof Event ? e.target : e;
              if (matches(element, Rails.linkDisableSelector)) {
                return disableLinkElement(element);
              } else if (matches(element, Rails.buttonDisableSelector) || matches(element, Rails.formDisableSelector)) {
                return disableFormElement(element);
              } else if (matches(element, Rails.formSubmitSelector)) {
                return disableFormElements(element);
              }
            };
            disableLinkElement = function(element) {
              var replacement;
              if (getData(element, "ujs:disabled")) {
                return;
              }
              replacement = element.getAttribute("data-disable-with");
              if (replacement != null) {
                setData(element, "ujs:enable-with", element.innerHTML);
                element.innerHTML = replacement;
              }
              element.addEventListener("click", stopEverything);
              return setData(element, "ujs:disabled", true);
            };
            enableLinkElement = function(element) {
              var originalText;
              originalText = getData(element, "ujs:enable-with");
              if (originalText != null) {
                element.innerHTML = originalText;
                setData(element, "ujs:enable-with", null);
              }
              element.removeEventListener("click", stopEverything);
              return setData(element, "ujs:disabled", null);
            };
            disableFormElements = function(form) {
              return formElements(form, Rails.formDisableSelector).forEach(disableFormElement);
            };
            disableFormElement = function(element) {
              var replacement;
              if (getData(element, "ujs:disabled")) {
                return;
              }
              replacement = element.getAttribute("data-disable-with");
              if (replacement != null) {
                if (matches(element, "button")) {
                  setData(element, "ujs:enable-with", element.innerHTML);
                  element.innerHTML = replacement;
                } else {
                  setData(element, "ujs:enable-with", element.value);
                  element.value = replacement;
                }
              }
              element.disabled = true;
              return setData(element, "ujs:disabled", true);
            };
            enableFormElements = function(form) {
              return formElements(form, Rails.formEnableSelector).forEach(enableFormElement);
            };
            enableFormElement = function(element) {
              var originalText;
              originalText = getData(element, "ujs:enable-with");
              if (originalText != null) {
                if (matches(element, "button")) {
                  element.innerHTML = originalText;
                } else {
                  element.value = originalText;
                }
                setData(element, "ujs:enable-with", null);
              }
              element.disabled = false;
              return setData(element, "ujs:disabled", null);
            };
            isXhrRedirect = function(event) {
              var ref, xhr;
              xhr = (ref = event.detail) != null ? ref[0] : void 0;
              return (xhr != null ? xhr.getResponseHeader("X-Xhr-Redirect") : void 0) != null;
            };
          }).call(this);
          (function() {
            var stopEverything;
            stopEverything = Rails.stopEverything;
            Rails.handleMethod = function(e) {
              var csrfParam, csrfToken, form, formContent, href, link, method;
              link = this;
              method = link.getAttribute("data-method");
              if (!method) {
                return;
              }
              href = Rails.href(link);
              csrfToken = Rails.csrfToken();
              csrfParam = Rails.csrfParam();
              form = document.createElement("form");
              formContent = "<input name='_method' value='" + method + "' type='hidden' />";
              if (csrfParam != null && csrfToken != null && !Rails.isCrossDomain(href)) {
                formContent += "<input name='" + csrfParam + "' value='" + csrfToken + "' type='hidden' />";
              }
              formContent += '<input type="submit" />';
              form.method = "post";
              form.action = href;
              form.target = link.target;
              form.innerHTML = formContent;
              form.style.display = "none";
              document.body.appendChild(form);
              form.querySelector('[type="submit"]').click();
              return stopEverything(e);
            };
          }).call(this);
          (function() {
            var ajax, fire, getData, isCrossDomain, isRemote, matches, serializeElement, setData, stopEverything, slice = [].slice;
            matches = Rails.matches, getData = Rails.getData, setData = Rails.setData, fire = Rails.fire, stopEverything = Rails.stopEverything, ajax = Rails.ajax, isCrossDomain = Rails.isCrossDomain, serializeElement = Rails.serializeElement;
            isRemote = function(element) {
              var value;
              value = element.getAttribute("data-remote");
              return value != null && value !== "false";
            };
            Rails.handleRemote = function(e) {
              var button, data, dataType, element, method, url, withCredentials;
              element = this;
              if (!isRemote(element)) {
                return true;
              }
              if (!fire(element, "ajax:before")) {
                fire(element, "ajax:stopped");
                return false;
              }
              withCredentials = element.getAttribute("data-with-credentials");
              dataType = element.getAttribute("data-type") || "script";
              if (matches(element, Rails.formSubmitSelector)) {
                button = getData(element, "ujs:submit-button");
                method = getData(element, "ujs:submit-button-formmethod") || element.method;
                url = getData(element, "ujs:submit-button-formaction") || element.getAttribute("action") || location.href;
                if (method.toUpperCase() === "GET") {
                  url = url.replace(/\?.*$/, "");
                }
                if (element.enctype === "multipart/form-data") {
                  data = new FormData(element);
                  if (button != null) {
                    data.append(button.name, button.value);
                  }
                } else {
                  data = serializeElement(element, button);
                }
                setData(element, "ujs:submit-button", null);
                setData(element, "ujs:submit-button-formmethod", null);
                setData(element, "ujs:submit-button-formaction", null);
              } else if (matches(element, Rails.buttonClickSelector) || matches(element, Rails.inputChangeSelector)) {
                method = element.getAttribute("data-method");
                url = element.getAttribute("data-url");
                data = serializeElement(element, element.getAttribute("data-params"));
              } else {
                method = element.getAttribute("data-method");
                url = Rails.href(element);
                data = element.getAttribute("data-params");
              }
              ajax({
                type: method || "GET",
                url,
                data,
                dataType,
                beforeSend: function(xhr, options) {
                  if (fire(element, "ajax:beforeSend", [xhr, options])) {
                    return fire(element, "ajax:send", [xhr]);
                  } else {
                    fire(element, "ajax:stopped");
                    return false;
                  }
                },
                success: function() {
                  var args;
                  args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
                  return fire(element, "ajax:success", args);
                },
                error: function() {
                  var args;
                  args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
                  return fire(element, "ajax:error", args);
                },
                complete: function() {
                  var args;
                  args = 1 <= arguments.length ? slice.call(arguments, 0) : [];
                  return fire(element, "ajax:complete", args);
                },
                crossDomain: isCrossDomain(url),
                withCredentials: withCredentials != null && withCredentials !== "false"
              });
              return stopEverything(e);
            };
            Rails.formSubmitButtonClick = function(e) {
              var button, form;
              button = this;
              form = button.form;
              if (!form) {
                return;
              }
              if (button.name) {
                setData(form, "ujs:submit-button", {
                  name: button.name,
                  value: button.value
                });
              }
              setData(form, "ujs:formnovalidate-button", button.formNoValidate);
              setData(form, "ujs:submit-button-formaction", button.getAttribute("formaction"));
              return setData(form, "ujs:submit-button-formmethod", button.getAttribute("formmethod"));
            };
            Rails.preventInsignificantClick = function(e) {
              var data, insignificantMetaClick, link, metaClick, method, nonPrimaryMouseClick;
              link = this;
              method = (link.getAttribute("data-method") || "GET").toUpperCase();
              data = link.getAttribute("data-params");
              metaClick = e.metaKey || e.ctrlKey;
              insignificantMetaClick = metaClick && method === "GET" && !data;
              nonPrimaryMouseClick = e.button != null && e.button !== 0;
              if (nonPrimaryMouseClick || insignificantMetaClick) {
                return e.stopImmediatePropagation();
              }
            };
          }).call(this);
          (function() {
            var $, CSRFProtection, delegate, disableElement, enableElement, fire, formSubmitButtonClick, getData, handleConfirm, handleDisabledElement, handleMethod, handleRemote, loadCSPNonce, preventInsignificantClick, refreshCSRFTokens;
            fire = Rails.fire, delegate = Rails.delegate, getData = Rails.getData, $ = Rails.$, refreshCSRFTokens = Rails.refreshCSRFTokens, CSRFProtection = Rails.CSRFProtection, loadCSPNonce = Rails.loadCSPNonce, enableElement = Rails.enableElement, disableElement = Rails.disableElement, handleDisabledElement = Rails.handleDisabledElement, handleConfirm = Rails.handleConfirm, preventInsignificantClick = Rails.preventInsignificantClick, handleRemote = Rails.handleRemote, formSubmitButtonClick = Rails.formSubmitButtonClick, handleMethod = Rails.handleMethod;
            if (typeof jQuery !== "undefined" && jQuery !== null && jQuery.ajax != null) {
              if (jQuery.rails) {
                throw new Error("If you load both jquery_ujs and rails-ujs, use rails-ujs only.");
              }
              jQuery.rails = Rails;
              jQuery.ajaxPrefilter(function(options, originalOptions, xhr) {
                if (!options.crossDomain) {
                  return CSRFProtection(xhr);
                }
              });
            }
            Rails.start = function() {
              if (window._rails_loaded) {
                throw new Error("rails-ujs has already been loaded!");
              }
              window.addEventListener("pageshow", function() {
                $(Rails.formEnableSelector).forEach(function(el) {
                  if (getData(el, "ujs:disabled")) {
                    return enableElement(el);
                  }
                });
                return $(Rails.linkDisableSelector).forEach(function(el) {
                  if (getData(el, "ujs:disabled")) {
                    return enableElement(el);
                  }
                });
              });
              delegate(document, Rails.linkDisableSelector, "ajax:complete", enableElement);
              delegate(document, Rails.linkDisableSelector, "ajax:stopped", enableElement);
              delegate(document, Rails.buttonDisableSelector, "ajax:complete", enableElement);
              delegate(document, Rails.buttonDisableSelector, "ajax:stopped", enableElement);
              delegate(document, Rails.linkClickSelector, "click", preventInsignificantClick);
              delegate(document, Rails.linkClickSelector, "click", handleDisabledElement);
              delegate(document, Rails.linkClickSelector, "click", handleConfirm);
              delegate(document, Rails.linkClickSelector, "click", disableElement);
              delegate(document, Rails.linkClickSelector, "click", handleRemote);
              delegate(document, Rails.linkClickSelector, "click", handleMethod);
              delegate(document, Rails.buttonClickSelector, "click", preventInsignificantClick);
              delegate(document, Rails.buttonClickSelector, "click", handleDisabledElement);
              delegate(document, Rails.buttonClickSelector, "click", handleConfirm);
              delegate(document, Rails.buttonClickSelector, "click", disableElement);
              delegate(document, Rails.buttonClickSelector, "click", handleRemote);
              delegate(document, Rails.inputChangeSelector, "change", handleDisabledElement);
              delegate(document, Rails.inputChangeSelector, "change", handleConfirm);
              delegate(document, Rails.inputChangeSelector, "change", handleRemote);
              delegate(document, Rails.formSubmitSelector, "submit", handleDisabledElement);
              delegate(document, Rails.formSubmitSelector, "submit", handleConfirm);
              delegate(document, Rails.formSubmitSelector, "submit", handleRemote);
              delegate(document, Rails.formSubmitSelector, "submit", function(e) {
                return setTimeout(function() {
                  return disableElement(e);
                }, 13);
              });
              delegate(document, Rails.formSubmitSelector, "ajax:send", disableElement);
              delegate(document, Rails.formSubmitSelector, "ajax:complete", enableElement);
              delegate(document, Rails.formInputClickSelector, "click", preventInsignificantClick);
              delegate(document, Rails.formInputClickSelector, "click", handleDisabledElement);
              delegate(document, Rails.formInputClickSelector, "click", handleConfirm);
              delegate(document, Rails.formInputClickSelector, "click", formSubmitButtonClick);
              document.addEventListener("DOMContentLoaded", refreshCSRFTokens);
              document.addEventListener("DOMContentLoaded", loadCSPNonce);
              return window._rails_loaded = true;
            };
            if (window.Rails === Rails && fire(document, "rails:attachBindings")) {
              Rails.start();
            }
          }).call(this);
        }).call(this);
        if (typeof module === "object" && module.exports) {
          module.exports = Rails;
        } else if (typeof define === "function" && define.amd) {
          define(Rails);
        }
      }).call(exports);
    }
  });

  // ../../node_modules/turbolinks/dist/turbolinks.js
  var require_turbolinks = __commonJS({
    "../../node_modules/turbolinks/dist/turbolinks.js"(exports, module) {
      (function() {
        var t = this;
        (function() {
          (function() {
            this.Turbolinks = { supported: function() {
              return window.history.pushState != null && window.requestAnimationFrame != null && window.addEventListener != null;
            }(), visit: function(t2, r) {
              return e.controller.visit(t2, r);
            }, clearCache: function() {
              return e.controller.clearCache();
            }, setProgressBarDelay: function(t2) {
              return e.controller.setProgressBarDelay(t2);
            } };
          }).call(this);
        }).call(t);
        var e = t.Turbolinks;
        (function() {
          (function() {
            var t2, r, n, o = [].slice;
            e.copyObject = function(t3) {
              var e2, r2, n2;
              r2 = {};
              for (e2 in t3)
                n2 = t3[e2], r2[e2] = n2;
              return r2;
            }, e.closest = function(e2, r2) {
              return t2.call(e2, r2);
            }, t2 = function() {
              var t3, e2;
              return t3 = document.documentElement, (e2 = t3.closest) != null ? e2 : function(t4) {
                var e3;
                for (e3 = this; e3; ) {
                  if (e3.nodeType === Node.ELEMENT_NODE && r.call(e3, t4))
                    return e3;
                  e3 = e3.parentNode;
                }
              };
            }(), e.defer = function(t3) {
              return setTimeout(t3, 1);
            }, e.throttle = function(t3) {
              var e2;
              return e2 = null, function() {
                var r2;
                return r2 = 1 <= arguments.length ? o.call(arguments, 0) : [], e2 != null ? e2 : e2 = requestAnimationFrame(function(n2) {
                  return function() {
                    return e2 = null, t3.apply(n2, r2);
                  };
                }(this));
              };
            }, e.dispatch = function(t3, e2) {
              var r2, o2, i, s, a, u;
              return a = e2 != null ? e2 : {}, u = a.target, r2 = a.cancelable, o2 = a.data, i = document.createEvent("Events"), i.initEvent(t3, true, r2 === true), i.data = o2 != null ? o2 : {}, i.cancelable && !n && (s = i.preventDefault, i.preventDefault = function() {
                return this.defaultPrevented || Object.defineProperty(this, "defaultPrevented", { get: function() {
                  return true;
                } }), s.call(this);
              }), (u != null ? u : document).dispatchEvent(i), i;
            }, n = function() {
              var t3;
              return t3 = document.createEvent("Events"), t3.initEvent("test", true, true), t3.preventDefault(), t3.defaultPrevented;
            }(), e.match = function(t3, e2) {
              return r.call(t3, e2);
            }, r = function() {
              var t3, e2, r2, n2;
              return t3 = document.documentElement, (e2 = (r2 = (n2 = t3.matchesSelector) != null ? n2 : t3.webkitMatchesSelector) != null ? r2 : t3.msMatchesSelector) != null ? e2 : t3.mozMatchesSelector;
            }(), e.uuid = function() {
              var t3, e2, r2;
              for (r2 = "", t3 = e2 = 1; 36 >= e2; t3 = ++e2)
                r2 += t3 === 9 || t3 === 14 || t3 === 19 || t3 === 24 ? "-" : t3 === 15 ? "4" : t3 === 20 ? (Math.floor(4 * Math.random()) + 8).toString(16) : Math.floor(15 * Math.random()).toString(16);
              return r2;
            };
          }).call(this), function() {
            e.Location = function() {
              function t2(t3) {
                var e3, r2;
                t3 == null && (t3 = ""), r2 = document.createElement("a"), r2.href = t3.toString(), this.absoluteURL = r2.href, e3 = r2.hash.length, 2 > e3 ? this.requestURL = this.absoluteURL : (this.requestURL = this.absoluteURL.slice(0, -e3), this.anchor = r2.hash.slice(1));
              }
              var e2, r, n, o;
              return t2.wrap = function(t3) {
                return t3 instanceof this ? t3 : new this(t3);
              }, t2.prototype.getOrigin = function() {
                return this.absoluteURL.split("/", 3).join("/");
              }, t2.prototype.getPath = function() {
                var t3, e3;
                return (t3 = (e3 = this.requestURL.match(/\/\/[^\/]*(\/[^?;]*)/)) != null ? e3[1] : void 0) != null ? t3 : "/";
              }, t2.prototype.getPathComponents = function() {
                return this.getPath().split("/").slice(1);
              }, t2.prototype.getLastPathComponent = function() {
                return this.getPathComponents().slice(-1)[0];
              }, t2.prototype.getExtension = function() {
                var t3, e3;
                return (t3 = (e3 = this.getLastPathComponent().match(/\.[^.]*$/)) != null ? e3[0] : void 0) != null ? t3 : "";
              }, t2.prototype.isHTML = function() {
                return this.getExtension().match(/^(?:|\.(?:htm|html|xhtml))$/);
              }, t2.prototype.isPrefixedBy = function(t3) {
                var e3;
                return e3 = r(t3), this.isEqualTo(t3) || o(this.absoluteURL, e3);
              }, t2.prototype.isEqualTo = function(t3) {
                return this.absoluteURL === (t3 != null ? t3.absoluteURL : void 0);
              }, t2.prototype.toCacheKey = function() {
                return this.requestURL;
              }, t2.prototype.toJSON = function() {
                return this.absoluteURL;
              }, t2.prototype.toString = function() {
                return this.absoluteURL;
              }, t2.prototype.valueOf = function() {
                return this.absoluteURL;
              }, r = function(t3) {
                return e2(t3.getOrigin() + t3.getPath());
              }, e2 = function(t3) {
                return n(t3, "/") ? t3 : t3 + "/";
              }, o = function(t3, e3) {
                return t3.slice(0, e3.length) === e3;
              }, n = function(t3, e3) {
                return t3.slice(-e3.length) === e3;
              }, t2;
            }();
          }.call(this), function() {
            var t2 = function(t3, e2) {
              return function() {
                return t3.apply(e2, arguments);
              };
            };
            e.HttpRequest = function() {
              function r(r2, n, o) {
                this.delegate = r2, this.requestCanceled = t2(this.requestCanceled, this), this.requestTimedOut = t2(this.requestTimedOut, this), this.requestFailed = t2(this.requestFailed, this), this.requestLoaded = t2(this.requestLoaded, this), this.requestProgressed = t2(this.requestProgressed, this), this.url = e.Location.wrap(n).requestURL, this.referrer = e.Location.wrap(o).absoluteURL, this.createXHR();
              }
              return r.NETWORK_FAILURE = 0, r.TIMEOUT_FAILURE = -1, r.timeout = 60, r.prototype.send = function() {
                var t3;
                return this.xhr && !this.sent ? (this.notifyApplicationBeforeRequestStart(), this.setProgress(0), this.xhr.send(), this.sent = true, typeof (t3 = this.delegate).requestStarted == "function" ? t3.requestStarted() : void 0) : void 0;
              }, r.prototype.cancel = function() {
                return this.xhr && this.sent ? this.xhr.abort() : void 0;
              }, r.prototype.requestProgressed = function(t3) {
                return t3.lengthComputable ? this.setProgress(t3.loaded / t3.total) : void 0;
              }, r.prototype.requestLoaded = function() {
                return this.endRequest(function(t3) {
                  return function() {
                    var e2;
                    return 200 <= (e2 = t3.xhr.status) && 300 > e2 ? t3.delegate.requestCompletedWithResponse(t3.xhr.responseText, t3.xhr.getResponseHeader("Turbolinks-Location")) : (t3.failed = true, t3.delegate.requestFailedWithStatusCode(t3.xhr.status, t3.xhr.responseText));
                  };
                }(this));
              }, r.prototype.requestFailed = function() {
                return this.endRequest(function(t3) {
                  return function() {
                    return t3.failed = true, t3.delegate.requestFailedWithStatusCode(t3.constructor.NETWORK_FAILURE);
                  };
                }(this));
              }, r.prototype.requestTimedOut = function() {
                return this.endRequest(function(t3) {
                  return function() {
                    return t3.failed = true, t3.delegate.requestFailedWithStatusCode(t3.constructor.TIMEOUT_FAILURE);
                  };
                }(this));
              }, r.prototype.requestCanceled = function() {
                return this.endRequest();
              }, r.prototype.notifyApplicationBeforeRequestStart = function() {
                return e.dispatch("turbolinks:request-start", { data: { url: this.url, xhr: this.xhr } });
              }, r.prototype.notifyApplicationAfterRequestEnd = function() {
                return e.dispatch("turbolinks:request-end", { data: { url: this.url, xhr: this.xhr } });
              }, r.prototype.createXHR = function() {
                return this.xhr = new XMLHttpRequest(), this.xhr.open("GET", this.url, true), this.xhr.timeout = 1e3 * this.constructor.timeout, this.xhr.setRequestHeader("Accept", "text/html, application/xhtml+xml"), this.xhr.setRequestHeader("Turbolinks-Referrer", this.referrer), this.xhr.onprogress = this.requestProgressed, this.xhr.onload = this.requestLoaded, this.xhr.onerror = this.requestFailed, this.xhr.ontimeout = this.requestTimedOut, this.xhr.onabort = this.requestCanceled;
              }, r.prototype.endRequest = function(t3) {
                return this.xhr ? (this.notifyApplicationAfterRequestEnd(), t3 != null && t3.call(this), this.destroy()) : void 0;
              }, r.prototype.setProgress = function(t3) {
                var e2;
                return this.progress = t3, typeof (e2 = this.delegate).requestProgressed == "function" ? e2.requestProgressed(this.progress) : void 0;
              }, r.prototype.destroy = function() {
                var t3;
                return this.setProgress(1), typeof (t3 = this.delegate).requestFinished == "function" && t3.requestFinished(), this.delegate = null, this.xhr = null;
              }, r;
            }();
          }.call(this), function() {
            var t2 = function(t3, e2) {
              return function() {
                return t3.apply(e2, arguments);
              };
            };
            e.ProgressBar = function() {
              function e2() {
                this.trickle = t2(this.trickle, this), this.stylesheetElement = this.createStylesheetElement(), this.progressElement = this.createProgressElement();
              }
              var r;
              return r = 300, e2.defaultCSS = ".turbolinks-progress-bar {\n  position: fixed;\n  display: block;\n  top: 0;\n  left: 0;\n  height: 3px;\n  background: #0076ff;\n  z-index: 9999;\n  transition: width " + r + "ms ease-out, opacity " + r / 2 + "ms " + r / 2 + "ms ease-in;\n  transform: translate3d(0, 0, 0);\n}", e2.prototype.show = function() {
                return this.visible ? void 0 : (this.visible = true, this.installStylesheetElement(), this.installProgressElement(), this.startTrickling());
              }, e2.prototype.hide = function() {
                return this.visible && !this.hiding ? (this.hiding = true, this.fadeProgressElement(function(t3) {
                  return function() {
                    return t3.uninstallProgressElement(), t3.stopTrickling(), t3.visible = false, t3.hiding = false;
                  };
                }(this))) : void 0;
              }, e2.prototype.setValue = function(t3) {
                return this.value = t3, this.refresh();
              }, e2.prototype.installStylesheetElement = function() {
                return document.head.insertBefore(this.stylesheetElement, document.head.firstChild);
              }, e2.prototype.installProgressElement = function() {
                return this.progressElement.style.width = 0, this.progressElement.style.opacity = 1, document.documentElement.insertBefore(this.progressElement, document.body), this.refresh();
              }, e2.prototype.fadeProgressElement = function(t3) {
                return this.progressElement.style.opacity = 0, setTimeout(t3, 1.5 * r);
              }, e2.prototype.uninstallProgressElement = function() {
                return this.progressElement.parentNode ? document.documentElement.removeChild(this.progressElement) : void 0;
              }, e2.prototype.startTrickling = function() {
                return this.trickleInterval != null ? this.trickleInterval : this.trickleInterval = setInterval(this.trickle, r);
              }, e2.prototype.stopTrickling = function() {
                return clearInterval(this.trickleInterval), this.trickleInterval = null;
              }, e2.prototype.trickle = function() {
                return this.setValue(this.value + Math.random() / 100);
              }, e2.prototype.refresh = function() {
                return requestAnimationFrame(function(t3) {
                  return function() {
                    return t3.progressElement.style.width = 10 + 90 * t3.value + "%";
                  };
                }(this));
              }, e2.prototype.createStylesheetElement = function() {
                var t3;
                return t3 = document.createElement("style"), t3.type = "text/css", t3.textContent = this.constructor.defaultCSS, t3;
              }, e2.prototype.createProgressElement = function() {
                var t3;
                return t3 = document.createElement("div"), t3.className = "turbolinks-progress-bar", t3;
              }, e2;
            }();
          }.call(this), function() {
            var t2 = function(t3, e2) {
              return function() {
                return t3.apply(e2, arguments);
              };
            };
            e.BrowserAdapter = function() {
              function r(r2) {
                this.controller = r2, this.showProgressBar = t2(this.showProgressBar, this), this.progressBar = new e.ProgressBar();
              }
              var n, o, i;
              return i = e.HttpRequest, n = i.NETWORK_FAILURE, o = i.TIMEOUT_FAILURE, r.prototype.visitProposedToLocationWithAction = function(t3, e2) {
                return this.controller.startVisitToLocationWithAction(t3, e2);
              }, r.prototype.visitStarted = function(t3) {
                return t3.issueRequest(), t3.changeHistory(), t3.loadCachedSnapshot();
              }, r.prototype.visitRequestStarted = function(t3) {
                return this.progressBar.setValue(0), t3.hasCachedSnapshot() || t3.action !== "restore" ? this.showProgressBarAfterDelay() : this.showProgressBar();
              }, r.prototype.visitRequestProgressed = function(t3) {
                return this.progressBar.setValue(t3.progress);
              }, r.prototype.visitRequestCompleted = function(t3) {
                return t3.loadResponse();
              }, r.prototype.visitRequestFailedWithStatusCode = function(t3, e2) {
                switch (e2) {
                  case n:
                  case o:
                    return this.reload();
                  default:
                    return t3.loadResponse();
                }
              }, r.prototype.visitRequestFinished = function(t3) {
                return this.hideProgressBar();
              }, r.prototype.visitCompleted = function(t3) {
                return t3.followRedirect();
              }, r.prototype.pageInvalidated = function() {
                return this.reload();
              }, r.prototype.showProgressBarAfterDelay = function() {
                return this.progressBarTimeout = setTimeout(this.showProgressBar, this.controller.progressBarDelay);
              }, r.prototype.showProgressBar = function() {
                return this.progressBar.show();
              }, r.prototype.hideProgressBar = function() {
                return this.progressBar.hide(), clearTimeout(this.progressBarTimeout);
              }, r.prototype.reload = function() {
                return window.location.reload();
              }, r;
            }();
          }.call(this), function() {
            var t2 = function(t3, e2) {
              return function() {
                return t3.apply(e2, arguments);
              };
            };
            e.History = function() {
              function r(e2) {
                this.delegate = e2, this.onPageLoad = t2(this.onPageLoad, this), this.onPopState = t2(this.onPopState, this);
              }
              return r.prototype.start = function() {
                return this.started ? void 0 : (addEventListener("popstate", this.onPopState, false), addEventListener("load", this.onPageLoad, false), this.started = true);
              }, r.prototype.stop = function() {
                return this.started ? (removeEventListener("popstate", this.onPopState, false), removeEventListener("load", this.onPageLoad, false), this.started = false) : void 0;
              }, r.prototype.push = function(t3, r2) {
                return t3 = e.Location.wrap(t3), this.update("push", t3, r2);
              }, r.prototype.replace = function(t3, r2) {
                return t3 = e.Location.wrap(t3), this.update("replace", t3, r2);
              }, r.prototype.onPopState = function(t3) {
                var r2, n, o, i;
                return this.shouldHandlePopState() && (i = (n = t3.state) != null ? n.turbolinks : void 0) ? (r2 = e.Location.wrap(window.location), o = i.restorationIdentifier, this.delegate.historyPoppedToLocationWithRestorationIdentifier(r2, o)) : void 0;
              }, r.prototype.onPageLoad = function(t3) {
                return e.defer(function(t4) {
                  return function() {
                    return t4.pageLoaded = true;
                  };
                }(this));
              }, r.prototype.shouldHandlePopState = function() {
                return this.pageIsLoaded();
              }, r.prototype.pageIsLoaded = function() {
                return this.pageLoaded || document.readyState === "complete";
              }, r.prototype.update = function(t3, e2, r2) {
                var n;
                return n = { turbolinks: { restorationIdentifier: r2 } }, history[t3 + "State"](n, null, e2);
              }, r;
            }();
          }.call(this), function() {
            e.HeadDetails = function() {
              function t2(t3) {
                var e3, r2, n2, s, a, u;
                for (this.elements = {}, n2 = 0, a = t3.length; a > n2; n2++)
                  u = t3[n2], u.nodeType === Node.ELEMENT_NODE && (s = u.outerHTML, r2 = (e3 = this.elements)[s] != null ? e3[s] : e3[s] = { type: i(u), tracked: o(u), elements: [] }, r2.elements.push(u));
              }
              var e2, r, n, o, i;
              return t2.fromHeadElement = function(t3) {
                var e3;
                return new this((e3 = t3 != null ? t3.childNodes : void 0) != null ? e3 : []);
              }, t2.prototype.hasElementWithKey = function(t3) {
                return t3 in this.elements;
              }, t2.prototype.getTrackedElementSignature = function() {
                var t3, e3;
                return function() {
                  var r2, n2;
                  r2 = this.elements, n2 = [];
                  for (t3 in r2)
                    e3 = r2[t3].tracked, e3 && n2.push(t3);
                  return n2;
                }.call(this).join("");
              }, t2.prototype.getScriptElementsNotInDetails = function(t3) {
                return this.getElementsMatchingTypeNotInDetails("script", t3);
              }, t2.prototype.getStylesheetElementsNotInDetails = function(t3) {
                return this.getElementsMatchingTypeNotInDetails("stylesheet", t3);
              }, t2.prototype.getElementsMatchingTypeNotInDetails = function(t3, e3) {
                var r2, n2, o2, i2, s, a;
                o2 = this.elements, s = [];
                for (n2 in o2)
                  i2 = o2[n2], a = i2.type, r2 = i2.elements, a !== t3 || e3.hasElementWithKey(n2) || s.push(r2[0]);
                return s;
              }, t2.prototype.getProvisionalElements = function() {
                var t3, e3, r2, n2, o2, i2, s;
                r2 = [], n2 = this.elements;
                for (e3 in n2)
                  o2 = n2[e3], s = o2.type, i2 = o2.tracked, t3 = o2.elements, s != null || i2 ? t3.length > 1 && r2.push.apply(r2, t3.slice(1)) : r2.push.apply(r2, t3);
                return r2;
              }, t2.prototype.getMetaValue = function(t3) {
                var e3;
                return (e3 = this.findMetaElementByName(t3)) != null ? e3.getAttribute("content") : void 0;
              }, t2.prototype.findMetaElementByName = function(t3) {
                var r2, n2, o2, i2;
                r2 = void 0, i2 = this.elements;
                for (o2 in i2)
                  n2 = i2[o2].elements, e2(n2[0], t3) && (r2 = n2[0]);
                return r2;
              }, i = function(t3) {
                return r(t3) ? "script" : n(t3) ? "stylesheet" : void 0;
              }, o = function(t3) {
                return t3.getAttribute("data-turbolinks-track") === "reload";
              }, r = function(t3) {
                var e3;
                return e3 = t3.tagName.toLowerCase(), e3 === "script";
              }, n = function(t3) {
                var e3;
                return e3 = t3.tagName.toLowerCase(), e3 === "style" || e3 === "link" && t3.getAttribute("rel") === "stylesheet";
              }, e2 = function(t3, e3) {
                var r2;
                return r2 = t3.tagName.toLowerCase(), r2 === "meta" && t3.getAttribute("name") === e3;
              }, t2;
            }();
          }.call(this), function() {
            e.Snapshot = function() {
              function t2(t3, e2) {
                this.headDetails = t3, this.bodyElement = e2;
              }
              return t2.wrap = function(t3) {
                return t3 instanceof this ? t3 : typeof t3 == "string" ? this.fromHTMLString(t3) : this.fromHTMLElement(t3);
              }, t2.fromHTMLString = function(t3) {
                var e2;
                return e2 = document.createElement("html"), e2.innerHTML = t3, this.fromHTMLElement(e2);
              }, t2.fromHTMLElement = function(t3) {
                var r, n, o, i;
                return o = t3.querySelector("head"), r = (i = t3.querySelector("body")) != null ? i : document.createElement("body"), n = e.HeadDetails.fromHeadElement(o), new this(n, r);
              }, t2.prototype.clone = function() {
                return new this.constructor(this.headDetails, this.bodyElement.cloneNode(true));
              }, t2.prototype.getRootLocation = function() {
                var t3, r;
                return r = (t3 = this.getSetting("root")) != null ? t3 : "/", new e.Location(r);
              }, t2.prototype.getCacheControlValue = function() {
                return this.getSetting("cache-control");
              }, t2.prototype.getElementForAnchor = function(t3) {
                try {
                  return this.bodyElement.querySelector("[id='" + t3 + "'], a[name='" + t3 + "']");
                } catch (e2) {
                }
              }, t2.prototype.getPermanentElements = function() {
                return this.bodyElement.querySelectorAll("[id][data-turbolinks-permanent]");
              }, t2.prototype.getPermanentElementById = function(t3) {
                return this.bodyElement.querySelector("#" + t3 + "[data-turbolinks-permanent]");
              }, t2.prototype.getPermanentElementsPresentInSnapshot = function(t3) {
                var e2, r, n, o, i;
                for (o = this.getPermanentElements(), i = [], r = 0, n = o.length; n > r; r++)
                  e2 = o[r], t3.getPermanentElementById(e2.id) && i.push(e2);
                return i;
              }, t2.prototype.findFirstAutofocusableElement = function() {
                return this.bodyElement.querySelector("[autofocus]");
              }, t2.prototype.hasAnchor = function(t3) {
                return this.getElementForAnchor(t3) != null;
              }, t2.prototype.isPreviewable = function() {
                return this.getCacheControlValue() !== "no-preview";
              }, t2.prototype.isCacheable = function() {
                return this.getCacheControlValue() !== "no-cache";
              }, t2.prototype.isVisitable = function() {
                return this.getSetting("visit-control") !== "reload";
              }, t2.prototype.getSetting = function(t3) {
                return this.headDetails.getMetaValue("turbolinks-" + t3);
              }, t2;
            }();
          }.call(this), function() {
            var t2 = [].slice;
            e.Renderer = function() {
              function e2() {
              }
              var r;
              return e2.render = function() {
                var e3, r2, n, o;
                return n = arguments[0], r2 = arguments[1], e3 = 3 <= arguments.length ? t2.call(arguments, 2) : [], o = function(t3, e4, r3) {
                  r3.prototype = t3.prototype;
                  var n2 = new r3(), o2 = t3.apply(n2, e4);
                  return Object(o2) === o2 ? o2 : n2;
                }(this, e3, function() {
                }), o.delegate = n, o.render(r2), o;
              }, e2.prototype.renderView = function(t3) {
                return this.delegate.viewWillRender(this.newBody), t3(), this.delegate.viewRendered(this.newBody);
              }, e2.prototype.invalidateView = function() {
                return this.delegate.viewInvalidated();
              }, e2.prototype.createScriptElement = function(t3) {
                var e3;
                return t3.getAttribute("data-turbolinks-eval") === "false" ? t3 : (e3 = document.createElement("script"), e3.textContent = t3.textContent, e3.async = false, r(e3, t3), e3);
              }, r = function(t3, e3) {
                var r2, n, o, i, s, a, u;
                for (i = e3.attributes, a = [], r2 = 0, n = i.length; n > r2; r2++)
                  s = i[r2], o = s.name, u = s.value, a.push(t3.setAttribute(o, u));
                return a;
              }, e2;
            }();
          }.call(this), function() {
            var t2, r, n = function(t3, e2) {
              function r2() {
                this.constructor = t3;
              }
              for (var n2 in e2)
                o.call(e2, n2) && (t3[n2] = e2[n2]);
              return r2.prototype = e2.prototype, t3.prototype = new r2(), t3.__super__ = e2.prototype, t3;
            }, o = {}.hasOwnProperty;
            e.SnapshotRenderer = function(e2) {
              function o2(t3, e3, r2) {
                this.currentSnapshot = t3, this.newSnapshot = e3, this.isPreview = r2, this.currentHeadDetails = this.currentSnapshot.headDetails, this.newHeadDetails = this.newSnapshot.headDetails, this.currentBody = this.currentSnapshot.bodyElement, this.newBody = this.newSnapshot.bodyElement;
              }
              return n(o2, e2), o2.prototype.render = function(t3) {
                return this.shouldRender() ? (this.mergeHead(), this.renderView(function(e3) {
                  return function() {
                    return e3.replaceBody(), e3.isPreview || e3.focusFirstAutofocusableElement(), t3();
                  };
                }(this))) : this.invalidateView();
              }, o2.prototype.mergeHead = function() {
                return this.copyNewHeadStylesheetElements(), this.copyNewHeadScriptElements(), this.removeCurrentHeadProvisionalElements(), this.copyNewHeadProvisionalElements();
              }, o2.prototype.replaceBody = function() {
                var t3;
                return t3 = this.relocateCurrentBodyPermanentElements(), this.activateNewBodyScriptElements(), this.assignNewBody(), this.replacePlaceholderElementsWithClonedPermanentElements(t3);
              }, o2.prototype.shouldRender = function() {
                return this.newSnapshot.isVisitable() && this.trackedElementsAreIdentical();
              }, o2.prototype.trackedElementsAreIdentical = function() {
                return this.currentHeadDetails.getTrackedElementSignature() === this.newHeadDetails.getTrackedElementSignature();
              }, o2.prototype.copyNewHeadStylesheetElements = function() {
                var t3, e3, r2, n2, o3;
                for (n2 = this.getNewHeadStylesheetElements(), o3 = [], e3 = 0, r2 = n2.length; r2 > e3; e3++)
                  t3 = n2[e3], o3.push(document.head.appendChild(t3));
                return o3;
              }, o2.prototype.copyNewHeadScriptElements = function() {
                var t3, e3, r2, n2, o3;
                for (n2 = this.getNewHeadScriptElements(), o3 = [], e3 = 0, r2 = n2.length; r2 > e3; e3++)
                  t3 = n2[e3], o3.push(document.head.appendChild(this.createScriptElement(t3)));
                return o3;
              }, o2.prototype.removeCurrentHeadProvisionalElements = function() {
                var t3, e3, r2, n2, o3;
                for (n2 = this.getCurrentHeadProvisionalElements(), o3 = [], e3 = 0, r2 = n2.length; r2 > e3; e3++)
                  t3 = n2[e3], o3.push(document.head.removeChild(t3));
                return o3;
              }, o2.prototype.copyNewHeadProvisionalElements = function() {
                var t3, e3, r2, n2, o3;
                for (n2 = this.getNewHeadProvisionalElements(), o3 = [], e3 = 0, r2 = n2.length; r2 > e3; e3++)
                  t3 = n2[e3], o3.push(document.head.appendChild(t3));
                return o3;
              }, o2.prototype.relocateCurrentBodyPermanentElements = function() {
                var e3, n2, o3, i, s, a, u;
                for (a = this.getCurrentBodyPermanentElements(), u = [], e3 = 0, n2 = a.length; n2 > e3; e3++)
                  i = a[e3], s = t2(i), o3 = this.newSnapshot.getPermanentElementById(i.id), r(i, s.element), r(o3, i), u.push(s);
                return u;
              }, o2.prototype.replacePlaceholderElementsWithClonedPermanentElements = function(t3) {
                var e3, n2, o3, i, s, a, u;
                for (u = [], o3 = 0, i = t3.length; i > o3; o3++)
                  a = t3[o3], n2 = a.element, s = a.permanentElement, e3 = s.cloneNode(true), u.push(r(n2, e3));
                return u;
              }, o2.prototype.activateNewBodyScriptElements = function() {
                var t3, e3, n2, o3, i, s;
                for (i = this.getNewBodyScriptElements(), s = [], e3 = 0, o3 = i.length; o3 > e3; e3++)
                  n2 = i[e3], t3 = this.createScriptElement(n2), s.push(r(n2, t3));
                return s;
              }, o2.prototype.assignNewBody = function() {
                return document.body = this.newBody;
              }, o2.prototype.focusFirstAutofocusableElement = function() {
                var t3;
                return (t3 = this.newSnapshot.findFirstAutofocusableElement()) != null ? t3.focus() : void 0;
              }, o2.prototype.getNewHeadStylesheetElements = function() {
                return this.newHeadDetails.getStylesheetElementsNotInDetails(this.currentHeadDetails);
              }, o2.prototype.getNewHeadScriptElements = function() {
                return this.newHeadDetails.getScriptElementsNotInDetails(this.currentHeadDetails);
              }, o2.prototype.getCurrentHeadProvisionalElements = function() {
                return this.currentHeadDetails.getProvisionalElements();
              }, o2.prototype.getNewHeadProvisionalElements = function() {
                return this.newHeadDetails.getProvisionalElements();
              }, o2.prototype.getCurrentBodyPermanentElements = function() {
                return this.currentSnapshot.getPermanentElementsPresentInSnapshot(this.newSnapshot);
              }, o2.prototype.getNewBodyScriptElements = function() {
                return this.newBody.querySelectorAll("script");
              }, o2;
            }(e.Renderer), t2 = function(t3) {
              var e2;
              return e2 = document.createElement("meta"), e2.setAttribute("name", "turbolinks-permanent-placeholder"), e2.setAttribute("content", t3.id), { element: e2, permanentElement: t3 };
            }, r = function(t3, e2) {
              var r2;
              return (r2 = t3.parentNode) ? r2.replaceChild(e2, t3) : void 0;
            };
          }.call(this), function() {
            var t2 = function(t3, e2) {
              function n() {
                this.constructor = t3;
              }
              for (var o in e2)
                r.call(e2, o) && (t3[o] = e2[o]);
              return n.prototype = e2.prototype, t3.prototype = new n(), t3.__super__ = e2.prototype, t3;
            }, r = {}.hasOwnProperty;
            e.ErrorRenderer = function(e2) {
              function r2(t3) {
                var e3;
                e3 = document.createElement("html"), e3.innerHTML = t3, this.newHead = e3.querySelector("head"), this.newBody = e3.querySelector("body");
              }
              return t2(r2, e2), r2.prototype.render = function(t3) {
                return this.renderView(function(e3) {
                  return function() {
                    return e3.replaceHeadAndBody(), e3.activateBodyScriptElements(), t3();
                  };
                }(this));
              }, r2.prototype.replaceHeadAndBody = function() {
                var t3, e3;
                return e3 = document.head, t3 = document.body, e3.parentNode.replaceChild(this.newHead, e3), t3.parentNode.replaceChild(this.newBody, t3);
              }, r2.prototype.activateBodyScriptElements = function() {
                var t3, e3, r3, n, o, i;
                for (n = this.getScriptElements(), i = [], e3 = 0, r3 = n.length; r3 > e3; e3++)
                  o = n[e3], t3 = this.createScriptElement(o), i.push(o.parentNode.replaceChild(t3, o));
                return i;
              }, r2.prototype.getScriptElements = function() {
                return document.documentElement.querySelectorAll("script");
              }, r2;
            }(e.Renderer);
          }.call(this), function() {
            e.View = function() {
              function t2(t3) {
                this.delegate = t3, this.htmlElement = document.documentElement;
              }
              return t2.prototype.getRootLocation = function() {
                return this.getSnapshot().getRootLocation();
              }, t2.prototype.getElementForAnchor = function(t3) {
                return this.getSnapshot().getElementForAnchor(t3);
              }, t2.prototype.getSnapshot = function() {
                return e.Snapshot.fromHTMLElement(this.htmlElement);
              }, t2.prototype.render = function(t3, e2) {
                var r, n, o;
                return o = t3.snapshot, r = t3.error, n = t3.isPreview, this.markAsPreview(n), o != null ? this.renderSnapshot(o, n, e2) : this.renderError(r, e2);
              }, t2.prototype.markAsPreview = function(t3) {
                return t3 ? this.htmlElement.setAttribute("data-turbolinks-preview", "") : this.htmlElement.removeAttribute("data-turbolinks-preview");
              }, t2.prototype.renderSnapshot = function(t3, r, n) {
                return e.SnapshotRenderer.render(this.delegate, n, this.getSnapshot(), e.Snapshot.wrap(t3), r);
              }, t2.prototype.renderError = function(t3, r) {
                return e.ErrorRenderer.render(this.delegate, r, t3);
              }, t2;
            }();
          }.call(this), function() {
            var t2 = function(t3, e2) {
              return function() {
                return t3.apply(e2, arguments);
              };
            };
            e.ScrollManager = function() {
              function r(r2) {
                this.delegate = r2, this.onScroll = t2(this.onScroll, this), this.onScroll = e.throttle(this.onScroll);
              }
              return r.prototype.start = function() {
                return this.started ? void 0 : (addEventListener("scroll", this.onScroll, false), this.onScroll(), this.started = true);
              }, r.prototype.stop = function() {
                return this.started ? (removeEventListener("scroll", this.onScroll, false), this.started = false) : void 0;
              }, r.prototype.scrollToElement = function(t3) {
                return t3.scrollIntoView();
              }, r.prototype.scrollToPosition = function(t3) {
                var e2, r2;
                return e2 = t3.x, r2 = t3.y, window.scrollTo(e2, r2);
              }, r.prototype.onScroll = function(t3) {
                return this.updatePosition({ x: window.pageXOffset, y: window.pageYOffset });
              }, r.prototype.updatePosition = function(t3) {
                var e2;
                return this.position = t3, (e2 = this.delegate) != null ? e2.scrollPositionChanged(this.position) : void 0;
              }, r;
            }();
          }.call(this), function() {
            e.SnapshotCache = function() {
              function t2(t3) {
                this.size = t3, this.keys = [], this.snapshots = {};
              }
              var r;
              return t2.prototype.has = function(t3) {
                var e2;
                return e2 = r(t3), e2 in this.snapshots;
              }, t2.prototype.get = function(t3) {
                var e2;
                if (this.has(t3))
                  return e2 = this.read(t3), this.touch(t3), e2;
              }, t2.prototype.put = function(t3, e2) {
                return this.write(t3, e2), this.touch(t3), e2;
              }, t2.prototype.read = function(t3) {
                var e2;
                return e2 = r(t3), this.snapshots[e2];
              }, t2.prototype.write = function(t3, e2) {
                var n;
                return n = r(t3), this.snapshots[n] = e2;
              }, t2.prototype.touch = function(t3) {
                var e2, n;
                return n = r(t3), e2 = this.keys.indexOf(n), e2 > -1 && this.keys.splice(e2, 1), this.keys.unshift(n), this.trim();
              }, t2.prototype.trim = function() {
                var t3, e2, r2, n, o;
                for (n = this.keys.splice(this.size), o = [], t3 = 0, r2 = n.length; r2 > t3; t3++)
                  e2 = n[t3], o.push(delete this.snapshots[e2]);
                return o;
              }, r = function(t3) {
                return e.Location.wrap(t3).toCacheKey();
              }, t2;
            }();
          }.call(this), function() {
            var t2 = function(t3, e2) {
              return function() {
                return t3.apply(e2, arguments);
              };
            };
            e.Visit = function() {
              function r(r2, n2, o) {
                this.controller = r2, this.action = o, this.performScroll = t2(this.performScroll, this), this.identifier = e.uuid(), this.location = e.Location.wrap(n2), this.adapter = this.controller.adapter, this.state = "initialized", this.timingMetrics = {};
              }
              var n;
              return r.prototype.start = function() {
                return this.state === "initialized" ? (this.recordTimingMetric("visitStart"), this.state = "started", this.adapter.visitStarted(this)) : void 0;
              }, r.prototype.cancel = function() {
                var t3;
                return this.state === "started" ? ((t3 = this.request) != null && t3.cancel(), this.cancelRender(), this.state = "canceled") : void 0;
              }, r.prototype.complete = function() {
                var t3;
                return this.state === "started" ? (this.recordTimingMetric("visitEnd"), this.state = "completed", typeof (t3 = this.adapter).visitCompleted == "function" && t3.visitCompleted(this), this.controller.visitCompleted(this)) : void 0;
              }, r.prototype.fail = function() {
                var t3;
                return this.state === "started" ? (this.state = "failed", typeof (t3 = this.adapter).visitFailed == "function" ? t3.visitFailed(this) : void 0) : void 0;
              }, r.prototype.changeHistory = function() {
                var t3, e2;
                return this.historyChanged ? void 0 : (t3 = this.location.isEqualTo(this.referrer) ? "replace" : this.action, e2 = n(t3), this.controller[e2](this.location, this.restorationIdentifier), this.historyChanged = true);
              }, r.prototype.issueRequest = function() {
                return this.shouldIssueRequest() && this.request == null ? (this.progress = 0, this.request = new e.HttpRequest(this, this.location, this.referrer), this.request.send()) : void 0;
              }, r.prototype.getCachedSnapshot = function() {
                var t3;
                return !(t3 = this.controller.getCachedSnapshotForLocation(this.location)) || this.location.anchor != null && !t3.hasAnchor(this.location.anchor) || this.action !== "restore" && !t3.isPreviewable() ? void 0 : t3;
              }, r.prototype.hasCachedSnapshot = function() {
                return this.getCachedSnapshot() != null;
              }, r.prototype.loadCachedSnapshot = function() {
                var t3, e2;
                return (e2 = this.getCachedSnapshot()) ? (t3 = this.shouldIssueRequest(), this.render(function() {
                  var r2;
                  return this.cacheSnapshot(), this.controller.render({ snapshot: e2, isPreview: t3 }, this.performScroll), typeof (r2 = this.adapter).visitRendered == "function" && r2.visitRendered(this), t3 ? void 0 : this.complete();
                })) : void 0;
              }, r.prototype.loadResponse = function() {
                return this.response != null ? this.render(function() {
                  var t3, e2;
                  return this.cacheSnapshot(), this.request.failed ? (this.controller.render({ error: this.response }, this.performScroll), typeof (t3 = this.adapter).visitRendered == "function" && t3.visitRendered(this), this.fail()) : (this.controller.render({ snapshot: this.response }, this.performScroll), typeof (e2 = this.adapter).visitRendered == "function" && e2.visitRendered(this), this.complete());
                }) : void 0;
              }, r.prototype.followRedirect = function() {
                return this.redirectedToLocation && !this.followedRedirect ? (this.location = this.redirectedToLocation, this.controller.replaceHistoryWithLocationAndRestorationIdentifier(this.redirectedToLocation, this.restorationIdentifier), this.followedRedirect = true) : void 0;
              }, r.prototype.requestStarted = function() {
                var t3;
                return this.recordTimingMetric("requestStart"), typeof (t3 = this.adapter).visitRequestStarted == "function" ? t3.visitRequestStarted(this) : void 0;
              }, r.prototype.requestProgressed = function(t3) {
                var e2;
                return this.progress = t3, typeof (e2 = this.adapter).visitRequestProgressed == "function" ? e2.visitRequestProgressed(this) : void 0;
              }, r.prototype.requestCompletedWithResponse = function(t3, r2) {
                return this.response = t3, r2 != null && (this.redirectedToLocation = e.Location.wrap(r2)), this.adapter.visitRequestCompleted(this);
              }, r.prototype.requestFailedWithStatusCode = function(t3, e2) {
                return this.response = e2, this.adapter.visitRequestFailedWithStatusCode(this, t3);
              }, r.prototype.requestFinished = function() {
                var t3;
                return this.recordTimingMetric("requestEnd"), typeof (t3 = this.adapter).visitRequestFinished == "function" ? t3.visitRequestFinished(this) : void 0;
              }, r.prototype.performScroll = function() {
                return this.scrolled ? void 0 : (this.action === "restore" ? this.scrollToRestoredPosition() || this.scrollToTop() : this.scrollToAnchor() || this.scrollToTop(), this.scrolled = true);
              }, r.prototype.scrollToRestoredPosition = function() {
                var t3, e2;
                return t3 = (e2 = this.restorationData) != null ? e2.scrollPosition : void 0, t3 != null ? (this.controller.scrollToPosition(t3), true) : void 0;
              }, r.prototype.scrollToAnchor = function() {
                return this.location.anchor != null ? (this.controller.scrollToAnchor(this.location.anchor), true) : void 0;
              }, r.prototype.scrollToTop = function() {
                return this.controller.scrollToPosition({ x: 0, y: 0 });
              }, r.prototype.recordTimingMetric = function(t3) {
                var e2;
                return (e2 = this.timingMetrics)[t3] != null ? e2[t3] : e2[t3] = new Date().getTime();
              }, r.prototype.getTimingMetrics = function() {
                return e.copyObject(this.timingMetrics);
              }, n = function(t3) {
                switch (t3) {
                  case "replace":
                    return "replaceHistoryWithLocationAndRestorationIdentifier";
                  case "advance":
                  case "restore":
                    return "pushHistoryWithLocationAndRestorationIdentifier";
                }
              }, r.prototype.shouldIssueRequest = function() {
                return this.action === "restore" ? !this.hasCachedSnapshot() : true;
              }, r.prototype.cacheSnapshot = function() {
                return this.snapshotCached ? void 0 : (this.controller.cacheSnapshot(), this.snapshotCached = true);
              }, r.prototype.render = function(t3) {
                return this.cancelRender(), this.frame = requestAnimationFrame(function(e2) {
                  return function() {
                    return e2.frame = null, t3.call(e2);
                  };
                }(this));
              }, r.prototype.cancelRender = function() {
                return this.frame ? cancelAnimationFrame(this.frame) : void 0;
              }, r;
            }();
          }.call(this), function() {
            var t2 = function(t3, e2) {
              return function() {
                return t3.apply(e2, arguments);
              };
            };
            e.Controller = function() {
              function r() {
                this.clickBubbled = t2(this.clickBubbled, this), this.clickCaptured = t2(this.clickCaptured, this), this.pageLoaded = t2(this.pageLoaded, this), this.history = new e.History(this), this.view = new e.View(this), this.scrollManager = new e.ScrollManager(this), this.restorationData = {}, this.clearCache(), this.setProgressBarDelay(500);
              }
              return r.prototype.start = function() {
                return e.supported && !this.started ? (addEventListener("click", this.clickCaptured, true), addEventListener("DOMContentLoaded", this.pageLoaded, false), this.scrollManager.start(), this.startHistory(), this.started = true, this.enabled = true) : void 0;
              }, r.prototype.disable = function() {
                return this.enabled = false;
              }, r.prototype.stop = function() {
                return this.started ? (removeEventListener("click", this.clickCaptured, true), removeEventListener("DOMContentLoaded", this.pageLoaded, false), this.scrollManager.stop(), this.stopHistory(), this.started = false) : void 0;
              }, r.prototype.clearCache = function() {
                return this.cache = new e.SnapshotCache(10);
              }, r.prototype.visit = function(t3, r2) {
                var n, o;
                return r2 == null && (r2 = {}), t3 = e.Location.wrap(t3), this.applicationAllowsVisitingLocation(t3) ? this.locationIsVisitable(t3) ? (n = (o = r2.action) != null ? o : "advance", this.adapter.visitProposedToLocationWithAction(t3, n)) : window.location = t3 : void 0;
              }, r.prototype.startVisitToLocationWithAction = function(t3, r2, n) {
                var o;
                return e.supported ? (o = this.getRestorationDataForIdentifier(n), this.startVisit(t3, r2, { restorationData: o })) : window.location = t3;
              }, r.prototype.setProgressBarDelay = function(t3) {
                return this.progressBarDelay = t3;
              }, r.prototype.startHistory = function() {
                return this.location = e.Location.wrap(window.location), this.restorationIdentifier = e.uuid(), this.history.start(), this.history.replace(this.location, this.restorationIdentifier);
              }, r.prototype.stopHistory = function() {
                return this.history.stop();
              }, r.prototype.pushHistoryWithLocationAndRestorationIdentifier = function(t3, r2) {
                return this.restorationIdentifier = r2, this.location = e.Location.wrap(t3), this.history.push(this.location, this.restorationIdentifier);
              }, r.prototype.replaceHistoryWithLocationAndRestorationIdentifier = function(t3, r2) {
                return this.restorationIdentifier = r2, this.location = e.Location.wrap(t3), this.history.replace(this.location, this.restorationIdentifier);
              }, r.prototype.historyPoppedToLocationWithRestorationIdentifier = function(t3, r2) {
                var n;
                return this.restorationIdentifier = r2, this.enabled ? (n = this.getRestorationDataForIdentifier(this.restorationIdentifier), this.startVisit(t3, "restore", { restorationIdentifier: this.restorationIdentifier, restorationData: n, historyChanged: true }), this.location = e.Location.wrap(t3)) : this.adapter.pageInvalidated();
              }, r.prototype.getCachedSnapshotForLocation = function(t3) {
                var e2;
                return (e2 = this.cache.get(t3)) != null ? e2.clone() : void 0;
              }, r.prototype.shouldCacheSnapshot = function() {
                return this.view.getSnapshot().isCacheable();
              }, r.prototype.cacheSnapshot = function() {
                var t3, r2;
                return this.shouldCacheSnapshot() ? (this.notifyApplicationBeforeCachingSnapshot(), r2 = this.view.getSnapshot(), t3 = this.lastRenderedLocation, e.defer(function(e2) {
                  return function() {
                    return e2.cache.put(t3, r2.clone());
                  };
                }(this))) : void 0;
              }, r.prototype.scrollToAnchor = function(t3) {
                var e2;
                return (e2 = this.view.getElementForAnchor(t3)) ? this.scrollToElement(e2) : this.scrollToPosition({ x: 0, y: 0 });
              }, r.prototype.scrollToElement = function(t3) {
                return this.scrollManager.scrollToElement(t3);
              }, r.prototype.scrollToPosition = function(t3) {
                return this.scrollManager.scrollToPosition(t3);
              }, r.prototype.scrollPositionChanged = function(t3) {
                var e2;
                return e2 = this.getCurrentRestorationData(), e2.scrollPosition = t3;
              }, r.prototype.render = function(t3, e2) {
                return this.view.render(t3, e2);
              }, r.prototype.viewInvalidated = function() {
                return this.adapter.pageInvalidated();
              }, r.prototype.viewWillRender = function(t3) {
                return this.notifyApplicationBeforeRender(t3);
              }, r.prototype.viewRendered = function() {
                return this.lastRenderedLocation = this.currentVisit.location, this.notifyApplicationAfterRender();
              }, r.prototype.pageLoaded = function() {
                return this.lastRenderedLocation = this.location, this.notifyApplicationAfterPageLoad();
              }, r.prototype.clickCaptured = function() {
                return removeEventListener("click", this.clickBubbled, false), addEventListener("click", this.clickBubbled, false);
              }, r.prototype.clickBubbled = function(t3) {
                var e2, r2, n;
                return this.enabled && this.clickEventIsSignificant(t3) && (r2 = this.getVisitableLinkForNode(t3.target)) && (n = this.getVisitableLocationForLink(r2)) && this.applicationAllowsFollowingLinkToLocation(r2, n) ? (t3.preventDefault(), e2 = this.getActionForLink(r2), this.visit(n, { action: e2 })) : void 0;
              }, r.prototype.applicationAllowsFollowingLinkToLocation = function(t3, e2) {
                var r2;
                return r2 = this.notifyApplicationAfterClickingLinkToLocation(t3, e2), !r2.defaultPrevented;
              }, r.prototype.applicationAllowsVisitingLocation = function(t3) {
                var e2;
                return e2 = this.notifyApplicationBeforeVisitingLocation(t3), !e2.defaultPrevented;
              }, r.prototype.notifyApplicationAfterClickingLinkToLocation = function(t3, r2) {
                return e.dispatch("turbolinks:click", { target: t3, data: { url: r2.absoluteURL }, cancelable: true });
              }, r.prototype.notifyApplicationBeforeVisitingLocation = function(t3) {
                return e.dispatch("turbolinks:before-visit", { data: { url: t3.absoluteURL }, cancelable: true });
              }, r.prototype.notifyApplicationAfterVisitingLocation = function(t3) {
                return e.dispatch("turbolinks:visit", { data: { url: t3.absoluteURL } });
              }, r.prototype.notifyApplicationBeforeCachingSnapshot = function() {
                return e.dispatch("turbolinks:before-cache");
              }, r.prototype.notifyApplicationBeforeRender = function(t3) {
                return e.dispatch("turbolinks:before-render", { data: { newBody: t3 } });
              }, r.prototype.notifyApplicationAfterRender = function() {
                return e.dispatch("turbolinks:render");
              }, r.prototype.notifyApplicationAfterPageLoad = function(t3) {
                return t3 == null && (t3 = {}), e.dispatch("turbolinks:load", { data: { url: this.location.absoluteURL, timing: t3 } });
              }, r.prototype.startVisit = function(t3, e2, r2) {
                var n;
                return (n = this.currentVisit) != null && n.cancel(), this.currentVisit = this.createVisit(t3, e2, r2), this.currentVisit.start(), this.notifyApplicationAfterVisitingLocation(t3);
              }, r.prototype.createVisit = function(t3, r2, n) {
                var o, i, s, a, u;
                return i = n != null ? n : {}, a = i.restorationIdentifier, s = i.restorationData, o = i.historyChanged, u = new e.Visit(this, t3, r2), u.restorationIdentifier = a != null ? a : e.uuid(), u.restorationData = e.copyObject(s), u.historyChanged = o, u.referrer = this.location, u;
              }, r.prototype.visitCompleted = function(t3) {
                return this.notifyApplicationAfterPageLoad(t3.getTimingMetrics());
              }, r.prototype.clickEventIsSignificant = function(t3) {
                return !(t3.defaultPrevented || t3.target.isContentEditable || t3.which > 1 || t3.altKey || t3.ctrlKey || t3.metaKey || t3.shiftKey);
              }, r.prototype.getVisitableLinkForNode = function(t3) {
                return this.nodeIsVisitable(t3) ? e.closest(t3, "a[href]:not([target]):not([download])") : void 0;
              }, r.prototype.getVisitableLocationForLink = function(t3) {
                var r2;
                return r2 = new e.Location(t3.getAttribute("href")), this.locationIsVisitable(r2) ? r2 : void 0;
              }, r.prototype.getActionForLink = function(t3) {
                var e2;
                return (e2 = t3.getAttribute("data-turbolinks-action")) != null ? e2 : "advance";
              }, r.prototype.nodeIsVisitable = function(t3) {
                var r2;
                return (r2 = e.closest(t3, "[data-turbolinks]")) ? r2.getAttribute("data-turbolinks") !== "false" : true;
              }, r.prototype.locationIsVisitable = function(t3) {
                return t3.isPrefixedBy(this.view.getRootLocation()) && t3.isHTML();
              }, r.prototype.getCurrentRestorationData = function() {
                return this.getRestorationDataForIdentifier(this.restorationIdentifier);
              }, r.prototype.getRestorationDataForIdentifier = function(t3) {
                var e2;
                return (e2 = this.restorationData)[t3] != null ? e2[t3] : e2[t3] = {};
              }, r;
            }();
          }.call(this), function() {
            !function() {
              var t2, e2;
              if ((t2 = e2 = document.currentScript) && !e2.hasAttribute("data-turbolinks-suppress-warning")) {
                for (; t2 = t2.parentNode; )
                  if (t2 === document.body)
                    return console.warn("You are loading Turbolinks from a <script> element inside the <body> element. This is probably not what you meant to do!\n\nLoad your application\u2019s JavaScript bundle inside the <head> element instead. <script> elements in <body> are evaluated with each page change.\n\nFor more information, see: https://github.com/turbolinks/turbolinks#working-with-script-elements\n\n\u2014\u2014\nSuppress this warning by adding a `data-turbolinks-suppress-warning` attribute to: %s", e2.outerHTML);
              }
            }();
          }.call(this), function() {
            var t2, r, n;
            e.start = function() {
              return r() ? (e.controller == null && (e.controller = t2()), e.controller.start()) : void 0;
            }, r = function() {
              return window.Turbolinks == null && (window.Turbolinks = e), n();
            }, t2 = function() {
              var t3;
              return t3 = new e.Controller(), t3.adapter = new e.BrowserAdapter(t3), t3;
            }, n = function() {
              return window.Turbolinks === e;
            }, n() && e.start();
          }.call(this);
        }).call(this), typeof module == "object" && module.exports ? module.exports = e : typeof define == "function" && define.amd && define(e);
      }).call(exports);
    }
  });

  // ../../node_modules/@stimulus/core/dist/src/event_listener.js
  var EventListener = function() {
    function EventListener2(eventTarget, eventName) {
      this.eventTarget = eventTarget;
      this.eventName = eventName;
      this.unorderedBindings = new Set();
    }
    EventListener2.prototype.connect = function() {
      this.eventTarget.addEventListener(this.eventName, this, false);
    };
    EventListener2.prototype.disconnect = function() {
      this.eventTarget.removeEventListener(this.eventName, this, false);
    };
    EventListener2.prototype.bindingConnected = function(binding) {
      this.unorderedBindings.add(binding);
    };
    EventListener2.prototype.bindingDisconnected = function(binding) {
      this.unorderedBindings.delete(binding);
    };
    EventListener2.prototype.handleEvent = function(event) {
      var extendedEvent = extendEvent(event);
      for (var _i = 0, _a = this.bindings; _i < _a.length; _i++) {
        var binding = _a[_i];
        if (extendedEvent.immediatePropagationStopped) {
          break;
        } else {
          binding.handleEvent(extendedEvent);
        }
      }
    };
    Object.defineProperty(EventListener2.prototype, "bindings", {
      get: function() {
        return Array.from(this.unorderedBindings).sort(function(left, right) {
          var leftIndex = left.index, rightIndex = right.index;
          return leftIndex < rightIndex ? -1 : leftIndex > rightIndex ? 1 : 0;
        });
      },
      enumerable: true,
      configurable: true
    });
    return EventListener2;
  }();
  function extendEvent(event) {
    if ("immediatePropagationStopped" in event) {
      return event;
    } else {
      var stopImmediatePropagation_1 = event.stopImmediatePropagation;
      return Object.assign(event, {
        immediatePropagationStopped: false,
        stopImmediatePropagation: function() {
          this.immediatePropagationStopped = true;
          stopImmediatePropagation_1.call(this);
        }
      });
    }
  }

  // ../../node_modules/@stimulus/core/dist/src/dispatcher.js
  var Dispatcher = function() {
    function Dispatcher2(application2) {
      this.application = application2;
      this.eventListenerMaps = new Map();
      this.started = false;
    }
    Dispatcher2.prototype.start = function() {
      if (!this.started) {
        this.started = true;
        this.eventListeners.forEach(function(eventListener) {
          return eventListener.connect();
        });
      }
    };
    Dispatcher2.prototype.stop = function() {
      if (this.started) {
        this.started = false;
        this.eventListeners.forEach(function(eventListener) {
          return eventListener.disconnect();
        });
      }
    };
    Object.defineProperty(Dispatcher2.prototype, "eventListeners", {
      get: function() {
        return Array.from(this.eventListenerMaps.values()).reduce(function(listeners, map) {
          return listeners.concat(Array.from(map.values()));
        }, []);
      },
      enumerable: true,
      configurable: true
    });
    Dispatcher2.prototype.bindingConnected = function(binding) {
      this.fetchEventListenerForBinding(binding).bindingConnected(binding);
    };
    Dispatcher2.prototype.bindingDisconnected = function(binding) {
      this.fetchEventListenerForBinding(binding).bindingDisconnected(binding);
    };
    Dispatcher2.prototype.handleError = function(error2, message, detail) {
      if (detail === void 0) {
        detail = {};
      }
      this.application.handleError(error2, "Error " + message, detail);
    };
    Dispatcher2.prototype.fetchEventListenerForBinding = function(binding) {
      var eventTarget = binding.eventTarget, eventName = binding.eventName;
      return this.fetchEventListener(eventTarget, eventName);
    };
    Dispatcher2.prototype.fetchEventListener = function(eventTarget, eventName) {
      var eventListenerMap = this.fetchEventListenerMapForEventTarget(eventTarget);
      var eventListener = eventListenerMap.get(eventName);
      if (!eventListener) {
        eventListener = this.createEventListener(eventTarget, eventName);
        eventListenerMap.set(eventName, eventListener);
      }
      return eventListener;
    };
    Dispatcher2.prototype.createEventListener = function(eventTarget, eventName) {
      var eventListener = new EventListener(eventTarget, eventName);
      if (this.started) {
        eventListener.connect();
      }
      return eventListener;
    };
    Dispatcher2.prototype.fetchEventListenerMapForEventTarget = function(eventTarget) {
      var eventListenerMap = this.eventListenerMaps.get(eventTarget);
      if (!eventListenerMap) {
        eventListenerMap = new Map();
        this.eventListenerMaps.set(eventTarget, eventListenerMap);
      }
      return eventListenerMap;
    };
    return Dispatcher2;
  }();

  // ../../node_modules/@stimulus/core/dist/src/action_descriptor.js
  var descriptorPattern = /^((.+?)(@(window|document))?->)?(.+?)(#(.+))?$/;
  function parseDescriptorString(descriptorString) {
    var source = descriptorString.trim();
    var matches = source.match(descriptorPattern) || [];
    return {
      eventTarget: parseEventTarget(matches[4]),
      eventName: matches[2],
      identifier: matches[5],
      methodName: matches[7]
    };
  }
  function parseEventTarget(eventTargetName) {
    if (eventTargetName == "window") {
      return window;
    } else if (eventTargetName == "document") {
      return document;
    }
  }
  function stringifyEventTarget(eventTarget) {
    if (eventTarget == window) {
      return "window";
    } else if (eventTarget == document) {
      return "document";
    }
  }

  // ../../node_modules/@stimulus/core/dist/src/action.js
  var Action = function() {
    function Action2(element, index, descriptor) {
      this.element = element;
      this.index = index;
      this.eventTarget = descriptor.eventTarget || element;
      this.eventName = descriptor.eventName || getDefaultEventNameForElement(element) || error("missing event name");
      this.identifier = descriptor.identifier || error("missing identifier");
      this.methodName = descriptor.methodName || error("missing method name");
    }
    Action2.forToken = function(token) {
      return new this(token.element, token.index, parseDescriptorString(token.content));
    };
    Action2.prototype.toString = function() {
      var eventNameSuffix = this.eventTargetName ? "@" + this.eventTargetName : "";
      return "" + this.eventName + eventNameSuffix + "->" + this.identifier + "#" + this.methodName;
    };
    Object.defineProperty(Action2.prototype, "eventTargetName", {
      get: function() {
        return stringifyEventTarget(this.eventTarget);
      },
      enumerable: true,
      configurable: true
    });
    return Action2;
  }();
  var defaultEventNames = {
    "a": function(e) {
      return "click";
    },
    "button": function(e) {
      return "click";
    },
    "form": function(e) {
      return "submit";
    },
    "input": function(e) {
      return e.getAttribute("type") == "submit" ? "click" : "change";
    },
    "select": function(e) {
      return "change";
    },
    "textarea": function(e) {
      return "change";
    }
  };
  function getDefaultEventNameForElement(element) {
    var tagName = element.tagName.toLowerCase();
    if (tagName in defaultEventNames) {
      return defaultEventNames[tagName](element);
    }
  }
  function error(message) {
    throw new Error(message);
  }

  // ../../node_modules/@stimulus/core/dist/src/binding.js
  var Binding = function() {
    function Binding2(context2, action) {
      this.context = context2;
      this.action = action;
    }
    Object.defineProperty(Binding2.prototype, "index", {
      get: function() {
        return this.action.index;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Binding2.prototype, "eventTarget", {
      get: function() {
        return this.action.eventTarget;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Binding2.prototype, "identifier", {
      get: function() {
        return this.context.identifier;
      },
      enumerable: true,
      configurable: true
    });
    Binding2.prototype.handleEvent = function(event) {
      if (this.willBeInvokedByEvent(event)) {
        this.invokeWithEvent(event);
      }
    };
    Object.defineProperty(Binding2.prototype, "eventName", {
      get: function() {
        return this.action.eventName;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Binding2.prototype, "method", {
      get: function() {
        var method = this.controller[this.methodName];
        if (typeof method == "function") {
          return method;
        }
        throw new Error('Action "' + this.action + '" references undefined method "' + this.methodName + '"');
      },
      enumerable: true,
      configurable: true
    });
    Binding2.prototype.invokeWithEvent = function(event) {
      try {
        this.method.call(this.controller, event);
      } catch (error2) {
        var _a = this, identifier = _a.identifier, controller = _a.controller, element = _a.element, index = _a.index;
        var detail = { identifier, controller, element, index, event };
        this.context.handleError(error2, 'invoking action "' + this.action + '"', detail);
      }
    };
    Binding2.prototype.willBeInvokedByEvent = function(event) {
      var eventTarget = event.target;
      if (this.element === eventTarget) {
        return true;
      } else if (eventTarget instanceof Element && this.element.contains(eventTarget)) {
        return this.scope.containsElement(eventTarget);
      } else {
        return true;
      }
    };
    Object.defineProperty(Binding2.prototype, "controller", {
      get: function() {
        return this.context.controller;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Binding2.prototype, "methodName", {
      get: function() {
        return this.action.methodName;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Binding2.prototype, "element", {
      get: function() {
        return this.scope.element;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Binding2.prototype, "scope", {
      get: function() {
        return this.context.scope;
      },
      enumerable: true,
      configurable: true
    });
    return Binding2;
  }();

  // ../../node_modules/@stimulus/mutation-observers/dist/src/element_observer.js
  var ElementObserver = function() {
    function ElementObserver2(element, delegate) {
      var _this = this;
      this.element = element;
      this.started = false;
      this.delegate = delegate;
      this.elements = new Set();
      this.mutationObserver = new MutationObserver(function(mutations) {
        return _this.processMutations(mutations);
      });
    }
    ElementObserver2.prototype.start = function() {
      if (!this.started) {
        this.started = true;
        this.mutationObserver.observe(this.element, { attributes: true, childList: true, subtree: true });
        this.refresh();
      }
    };
    ElementObserver2.prototype.stop = function() {
      if (this.started) {
        this.mutationObserver.takeRecords();
        this.mutationObserver.disconnect();
        this.started = false;
      }
    };
    ElementObserver2.prototype.refresh = function() {
      if (this.started) {
        var matches = new Set(this.matchElementsInTree());
        for (var _i = 0, _a = Array.from(this.elements); _i < _a.length; _i++) {
          var element = _a[_i];
          if (!matches.has(element)) {
            this.removeElement(element);
          }
        }
        for (var _b = 0, _c = Array.from(matches); _b < _c.length; _b++) {
          var element = _c[_b];
          this.addElement(element);
        }
      }
    };
    ElementObserver2.prototype.processMutations = function(mutations) {
      if (this.started) {
        for (var _i = 0, mutations_1 = mutations; _i < mutations_1.length; _i++) {
          var mutation = mutations_1[_i];
          this.processMutation(mutation);
        }
      }
    };
    ElementObserver2.prototype.processMutation = function(mutation) {
      if (mutation.type == "attributes") {
        this.processAttributeChange(mutation.target, mutation.attributeName);
      } else if (mutation.type == "childList") {
        this.processRemovedNodes(mutation.removedNodes);
        this.processAddedNodes(mutation.addedNodes);
      }
    };
    ElementObserver2.prototype.processAttributeChange = function(node, attributeName) {
      var element = node;
      if (this.elements.has(element)) {
        if (this.delegate.elementAttributeChanged && this.matchElement(element)) {
          this.delegate.elementAttributeChanged(element, attributeName);
        } else {
          this.removeElement(element);
        }
      } else if (this.matchElement(element)) {
        this.addElement(element);
      }
    };
    ElementObserver2.prototype.processRemovedNodes = function(nodes) {
      for (var _i = 0, _a = Array.from(nodes); _i < _a.length; _i++) {
        var node = _a[_i];
        var element = this.elementFromNode(node);
        if (element) {
          this.processTree(element, this.removeElement);
        }
      }
    };
    ElementObserver2.prototype.processAddedNodes = function(nodes) {
      for (var _i = 0, _a = Array.from(nodes); _i < _a.length; _i++) {
        var node = _a[_i];
        var element = this.elementFromNode(node);
        if (element && this.elementIsActive(element)) {
          this.processTree(element, this.addElement);
        }
      }
    };
    ElementObserver2.prototype.matchElement = function(element) {
      return this.delegate.matchElement(element);
    };
    ElementObserver2.prototype.matchElementsInTree = function(tree) {
      if (tree === void 0) {
        tree = this.element;
      }
      return this.delegate.matchElementsInTree(tree);
    };
    ElementObserver2.prototype.processTree = function(tree, processor) {
      for (var _i = 0, _a = this.matchElementsInTree(tree); _i < _a.length; _i++) {
        var element = _a[_i];
        processor.call(this, element);
      }
    };
    ElementObserver2.prototype.elementFromNode = function(node) {
      if (node.nodeType == Node.ELEMENT_NODE) {
        return node;
      }
    };
    ElementObserver2.prototype.elementIsActive = function(element) {
      if (element.isConnected != this.element.isConnected) {
        return false;
      } else {
        return this.element.contains(element);
      }
    };
    ElementObserver2.prototype.addElement = function(element) {
      if (!this.elements.has(element)) {
        if (this.elementIsActive(element)) {
          this.elements.add(element);
          if (this.delegate.elementMatched) {
            this.delegate.elementMatched(element);
          }
        }
      }
    };
    ElementObserver2.prototype.removeElement = function(element) {
      if (this.elements.has(element)) {
        this.elements.delete(element);
        if (this.delegate.elementUnmatched) {
          this.delegate.elementUnmatched(element);
        }
      }
    };
    return ElementObserver2;
  }();

  // ../../node_modules/@stimulus/mutation-observers/dist/src/attribute_observer.js
  var AttributeObserver = function() {
    function AttributeObserver2(element, attributeName, delegate) {
      this.attributeName = attributeName;
      this.delegate = delegate;
      this.elementObserver = new ElementObserver(element, this);
    }
    Object.defineProperty(AttributeObserver2.prototype, "element", {
      get: function() {
        return this.elementObserver.element;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(AttributeObserver2.prototype, "selector", {
      get: function() {
        return "[" + this.attributeName + "]";
      },
      enumerable: true,
      configurable: true
    });
    AttributeObserver2.prototype.start = function() {
      this.elementObserver.start();
    };
    AttributeObserver2.prototype.stop = function() {
      this.elementObserver.stop();
    };
    AttributeObserver2.prototype.refresh = function() {
      this.elementObserver.refresh();
    };
    Object.defineProperty(AttributeObserver2.prototype, "started", {
      get: function() {
        return this.elementObserver.started;
      },
      enumerable: true,
      configurable: true
    });
    AttributeObserver2.prototype.matchElement = function(element) {
      return element.hasAttribute(this.attributeName);
    };
    AttributeObserver2.prototype.matchElementsInTree = function(tree) {
      var match = this.matchElement(tree) ? [tree] : [];
      var matches = Array.from(tree.querySelectorAll(this.selector));
      return match.concat(matches);
    };
    AttributeObserver2.prototype.elementMatched = function(element) {
      if (this.delegate.elementMatchedAttribute) {
        this.delegate.elementMatchedAttribute(element, this.attributeName);
      }
    };
    AttributeObserver2.prototype.elementUnmatched = function(element) {
      if (this.delegate.elementUnmatchedAttribute) {
        this.delegate.elementUnmatchedAttribute(element, this.attributeName);
      }
    };
    AttributeObserver2.prototype.elementAttributeChanged = function(element, attributeName) {
      if (this.delegate.elementAttributeValueChanged && this.attributeName == attributeName) {
        this.delegate.elementAttributeValueChanged(element, attributeName);
      }
    };
    return AttributeObserver2;
  }();

  // ../../node_modules/@stimulus/multimap/dist/src/set_operations.js
  function add(map, key, value) {
    fetch(map, key).add(value);
  }
  function del(map, key, value) {
    fetch(map, key).delete(value);
    prune(map, key);
  }
  function fetch(map, key) {
    var values = map.get(key);
    if (!values) {
      values = new Set();
      map.set(key, values);
    }
    return values;
  }
  function prune(map, key) {
    var values = map.get(key);
    if (values != null && values.size == 0) {
      map.delete(key);
    }
  }

  // ../../node_modules/@stimulus/multimap/dist/src/multimap.js
  var Multimap = function() {
    function Multimap2() {
      this.valuesByKey = new Map();
    }
    Object.defineProperty(Multimap2.prototype, "values", {
      get: function() {
        var sets = Array.from(this.valuesByKey.values());
        return sets.reduce(function(values, set) {
          return values.concat(Array.from(set));
        }, []);
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Multimap2.prototype, "size", {
      get: function() {
        var sets = Array.from(this.valuesByKey.values());
        return sets.reduce(function(size, set) {
          return size + set.size;
        }, 0);
      },
      enumerable: true,
      configurable: true
    });
    Multimap2.prototype.add = function(key, value) {
      add(this.valuesByKey, key, value);
    };
    Multimap2.prototype.delete = function(key, value) {
      del(this.valuesByKey, key, value);
    };
    Multimap2.prototype.has = function(key, value) {
      var values = this.valuesByKey.get(key);
      return values != null && values.has(value);
    };
    Multimap2.prototype.hasKey = function(key) {
      return this.valuesByKey.has(key);
    };
    Multimap2.prototype.hasValue = function(value) {
      var sets = Array.from(this.valuesByKey.values());
      return sets.some(function(set) {
        return set.has(value);
      });
    };
    Multimap2.prototype.getValuesForKey = function(key) {
      var values = this.valuesByKey.get(key);
      return values ? Array.from(values) : [];
    };
    Multimap2.prototype.getKeysForValue = function(value) {
      return Array.from(this.valuesByKey).filter(function(_a) {
        var key = _a[0], values = _a[1];
        return values.has(value);
      }).map(function(_a) {
        var key = _a[0], values = _a[1];
        return key;
      });
    };
    return Multimap2;
  }();

  // ../../node_modules/@stimulus/multimap/dist/src/indexed_multimap.js
  var __extends = function() {
    var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function(d, b) {
      d.__proto__ = b;
    } || function(d, b) {
      for (var p in b)
        if (b.hasOwnProperty(p))
          d[p] = b[p];
    };
    return function(d, b) {
      extendStatics(d, b);
      function __() {
        this.constructor = d;
      }
      d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
  }();
  var IndexedMultimap = function(_super) {
    __extends(IndexedMultimap2, _super);
    function IndexedMultimap2() {
      var _this = _super.call(this) || this;
      _this.keysByValue = new Map();
      return _this;
    }
    Object.defineProperty(IndexedMultimap2.prototype, "values", {
      get: function() {
        return Array.from(this.keysByValue.keys());
      },
      enumerable: true,
      configurable: true
    });
    IndexedMultimap2.prototype.add = function(key, value) {
      _super.prototype.add.call(this, key, value);
      add(this.keysByValue, value, key);
    };
    IndexedMultimap2.prototype.delete = function(key, value) {
      _super.prototype.delete.call(this, key, value);
      del(this.keysByValue, value, key);
    };
    IndexedMultimap2.prototype.hasValue = function(value) {
      return this.keysByValue.has(value);
    };
    IndexedMultimap2.prototype.getKeysForValue = function(value) {
      var set = this.keysByValue.get(value);
      return set ? Array.from(set) : [];
    };
    return IndexedMultimap2;
  }(Multimap);

  // ../../node_modules/@stimulus/mutation-observers/dist/src/token_list_observer.js
  var TokenListObserver = function() {
    function TokenListObserver2(element, attributeName, delegate) {
      this.attributeObserver = new AttributeObserver(element, attributeName, this);
      this.delegate = delegate;
      this.tokensByElement = new Multimap();
    }
    Object.defineProperty(TokenListObserver2.prototype, "started", {
      get: function() {
        return this.attributeObserver.started;
      },
      enumerable: true,
      configurable: true
    });
    TokenListObserver2.prototype.start = function() {
      this.attributeObserver.start();
    };
    TokenListObserver2.prototype.stop = function() {
      this.attributeObserver.stop();
    };
    TokenListObserver2.prototype.refresh = function() {
      this.attributeObserver.refresh();
    };
    Object.defineProperty(TokenListObserver2.prototype, "element", {
      get: function() {
        return this.attributeObserver.element;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(TokenListObserver2.prototype, "attributeName", {
      get: function() {
        return this.attributeObserver.attributeName;
      },
      enumerable: true,
      configurable: true
    });
    TokenListObserver2.prototype.elementMatchedAttribute = function(element) {
      this.tokensMatched(this.readTokensForElement(element));
    };
    TokenListObserver2.prototype.elementAttributeValueChanged = function(element) {
      var _a = this.refreshTokensForElement(element), unmatchedTokens = _a[0], matchedTokens = _a[1];
      this.tokensUnmatched(unmatchedTokens);
      this.tokensMatched(matchedTokens);
    };
    TokenListObserver2.prototype.elementUnmatchedAttribute = function(element) {
      this.tokensUnmatched(this.tokensByElement.getValuesForKey(element));
    };
    TokenListObserver2.prototype.tokensMatched = function(tokens) {
      var _this = this;
      tokens.forEach(function(token) {
        return _this.tokenMatched(token);
      });
    };
    TokenListObserver2.prototype.tokensUnmatched = function(tokens) {
      var _this = this;
      tokens.forEach(function(token) {
        return _this.tokenUnmatched(token);
      });
    };
    TokenListObserver2.prototype.tokenMatched = function(token) {
      this.delegate.tokenMatched(token);
      this.tokensByElement.add(token.element, token);
    };
    TokenListObserver2.prototype.tokenUnmatched = function(token) {
      this.delegate.tokenUnmatched(token);
      this.tokensByElement.delete(token.element, token);
    };
    TokenListObserver2.prototype.refreshTokensForElement = function(element) {
      var previousTokens = this.tokensByElement.getValuesForKey(element);
      var currentTokens = this.readTokensForElement(element);
      var firstDifferingIndex = zip(previousTokens, currentTokens).findIndex(function(_a) {
        var previousToken = _a[0], currentToken = _a[1];
        return !tokensAreEqual(previousToken, currentToken);
      });
      if (firstDifferingIndex == -1) {
        return [[], []];
      } else {
        return [previousTokens.slice(firstDifferingIndex), currentTokens.slice(firstDifferingIndex)];
      }
    };
    TokenListObserver2.prototype.readTokensForElement = function(element) {
      var attributeName = this.attributeName;
      var tokenString = element.getAttribute(attributeName) || "";
      return parseTokenString(tokenString, element, attributeName);
    };
    return TokenListObserver2;
  }();
  function parseTokenString(tokenString, element, attributeName) {
    return tokenString.trim().split(/\s+/).filter(function(content) {
      return content.length;
    }).map(function(content, index) {
      return { element, attributeName, content, index };
    });
  }
  function zip(left, right) {
    var length = Math.max(left.length, right.length);
    return Array.from({ length }, function(_, index) {
      return [left[index], right[index]];
    });
  }
  function tokensAreEqual(left, right) {
    return left && right && left.index == right.index && left.content == right.content;
  }

  // ../../node_modules/@stimulus/mutation-observers/dist/src/value_list_observer.js
  var ValueListObserver = function() {
    function ValueListObserver2(element, attributeName, delegate) {
      this.tokenListObserver = new TokenListObserver(element, attributeName, this);
      this.delegate = delegate;
      this.parseResultsByToken = new WeakMap();
      this.valuesByTokenByElement = new WeakMap();
    }
    Object.defineProperty(ValueListObserver2.prototype, "started", {
      get: function() {
        return this.tokenListObserver.started;
      },
      enumerable: true,
      configurable: true
    });
    ValueListObserver2.prototype.start = function() {
      this.tokenListObserver.start();
    };
    ValueListObserver2.prototype.stop = function() {
      this.tokenListObserver.stop();
    };
    ValueListObserver2.prototype.refresh = function() {
      this.tokenListObserver.refresh();
    };
    Object.defineProperty(ValueListObserver2.prototype, "element", {
      get: function() {
        return this.tokenListObserver.element;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(ValueListObserver2.prototype, "attributeName", {
      get: function() {
        return this.tokenListObserver.attributeName;
      },
      enumerable: true,
      configurable: true
    });
    ValueListObserver2.prototype.tokenMatched = function(token) {
      var element = token.element;
      var value = this.fetchParseResultForToken(token).value;
      if (value) {
        this.fetchValuesByTokenForElement(element).set(token, value);
        this.delegate.elementMatchedValue(element, value);
      }
    };
    ValueListObserver2.prototype.tokenUnmatched = function(token) {
      var element = token.element;
      var value = this.fetchParseResultForToken(token).value;
      if (value) {
        this.fetchValuesByTokenForElement(element).delete(token);
        this.delegate.elementUnmatchedValue(element, value);
      }
    };
    ValueListObserver2.prototype.fetchParseResultForToken = function(token) {
      var parseResult = this.parseResultsByToken.get(token);
      if (!parseResult) {
        parseResult = this.parseToken(token);
        this.parseResultsByToken.set(token, parseResult);
      }
      return parseResult;
    };
    ValueListObserver2.prototype.fetchValuesByTokenForElement = function(element) {
      var valuesByToken = this.valuesByTokenByElement.get(element);
      if (!valuesByToken) {
        valuesByToken = new Map();
        this.valuesByTokenByElement.set(element, valuesByToken);
      }
      return valuesByToken;
    };
    ValueListObserver2.prototype.parseToken = function(token) {
      try {
        var value = this.delegate.parseValueForToken(token);
        return { value };
      } catch (error2) {
        return { error: error2 };
      }
    };
    return ValueListObserver2;
  }();

  // ../../node_modules/@stimulus/core/dist/src/binding_observer.js
  var BindingObserver = function() {
    function BindingObserver2(context2, delegate) {
      this.context = context2;
      this.delegate = delegate;
      this.bindingsByAction = new Map();
    }
    BindingObserver2.prototype.start = function() {
      if (!this.valueListObserver) {
        this.valueListObserver = new ValueListObserver(this.element, this.actionAttribute, this);
        this.valueListObserver.start();
      }
    };
    BindingObserver2.prototype.stop = function() {
      if (this.valueListObserver) {
        this.valueListObserver.stop();
        delete this.valueListObserver;
        this.disconnectAllActions();
      }
    };
    Object.defineProperty(BindingObserver2.prototype, "element", {
      get: function() {
        return this.context.element;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(BindingObserver2.prototype, "identifier", {
      get: function() {
        return this.context.identifier;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(BindingObserver2.prototype, "actionAttribute", {
      get: function() {
        return this.schema.actionAttribute;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(BindingObserver2.prototype, "schema", {
      get: function() {
        return this.context.schema;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(BindingObserver2.prototype, "bindings", {
      get: function() {
        return Array.from(this.bindingsByAction.values());
      },
      enumerable: true,
      configurable: true
    });
    BindingObserver2.prototype.connectAction = function(action) {
      var binding = new Binding(this.context, action);
      this.bindingsByAction.set(action, binding);
      this.delegate.bindingConnected(binding);
    };
    BindingObserver2.prototype.disconnectAction = function(action) {
      var binding = this.bindingsByAction.get(action);
      if (binding) {
        this.bindingsByAction.delete(action);
        this.delegate.bindingDisconnected(binding);
      }
    };
    BindingObserver2.prototype.disconnectAllActions = function() {
      var _this = this;
      this.bindings.forEach(function(binding) {
        return _this.delegate.bindingDisconnected(binding);
      });
      this.bindingsByAction.clear();
    };
    BindingObserver2.prototype.parseValueForToken = function(token) {
      var action = Action.forToken(token);
      if (action.identifier == this.identifier) {
        return action;
      }
    };
    BindingObserver2.prototype.elementMatchedValue = function(element, action) {
      this.connectAction(action);
    };
    BindingObserver2.prototype.elementUnmatchedValue = function(element, action) {
      this.disconnectAction(action);
    };
    return BindingObserver2;
  }();

  // ../../node_modules/@stimulus/core/dist/src/context.js
  var Context = function() {
    function Context2(module, scope) {
      this.module = module;
      this.scope = scope;
      this.controller = new module.controllerConstructor(this);
      this.bindingObserver = new BindingObserver(this, this.dispatcher);
      try {
        this.controller.initialize();
      } catch (error2) {
        this.handleError(error2, "initializing controller");
      }
    }
    Context2.prototype.connect = function() {
      this.bindingObserver.start();
      try {
        this.controller.connect();
      } catch (error2) {
        this.handleError(error2, "connecting controller");
      }
    };
    Context2.prototype.disconnect = function() {
      try {
        this.controller.disconnect();
      } catch (error2) {
        this.handleError(error2, "disconnecting controller");
      }
      this.bindingObserver.stop();
    };
    Object.defineProperty(Context2.prototype, "application", {
      get: function() {
        return this.module.application;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Context2.prototype, "identifier", {
      get: function() {
        return this.module.identifier;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Context2.prototype, "schema", {
      get: function() {
        return this.application.schema;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Context2.prototype, "dispatcher", {
      get: function() {
        return this.application.dispatcher;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Context2.prototype, "element", {
      get: function() {
        return this.scope.element;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Context2.prototype, "parentElement", {
      get: function() {
        return this.element.parentElement;
      },
      enumerable: true,
      configurable: true
    });
    Context2.prototype.handleError = function(error2, message, detail) {
      if (detail === void 0) {
        detail = {};
      }
      var _a = this, identifier = _a.identifier, controller = _a.controller, element = _a.element;
      detail = Object.assign({ identifier, controller, element }, detail);
      this.application.handleError(error2, "Error " + message, detail);
    };
    return Context2;
  }();

  // ../../node_modules/@stimulus/core/dist/src/definition.js
  var __extends2 = function() {
    var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function(d, b) {
      d.__proto__ = b;
    } || function(d, b) {
      for (var p in b)
        if (b.hasOwnProperty(p))
          d[p] = b[p];
    };
    return function(d, b) {
      extendStatics(d, b);
      function __() {
        this.constructor = d;
      }
      d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
  }();
  function blessDefinition(definition) {
    return {
      identifier: definition.identifier,
      controllerConstructor: blessControllerConstructor(definition.controllerConstructor)
    };
  }
  function blessControllerConstructor(controllerConstructor) {
    var constructor = extend(controllerConstructor);
    constructor.bless();
    return constructor;
  }
  var extend = function() {
    function extendWithReflect(constructor) {
      function Controller2() {
        var _newTarget = this && this instanceof Controller2 ? this.constructor : void 0;
        return Reflect.construct(constructor, arguments, _newTarget);
      }
      Controller2.prototype = Object.create(constructor.prototype, {
        constructor: { value: Controller2 }
      });
      Reflect.setPrototypeOf(Controller2, constructor);
      return Controller2;
    }
    function testReflectExtension() {
      var a = function() {
        this.a.call(this);
      };
      var b = extendWithReflect(a);
      b.prototype.a = function() {
      };
      return new b();
    }
    try {
      testReflectExtension();
      return extendWithReflect;
    } catch (error2) {
      return function(constructor) {
        return function(_super) {
          __extends2(Controller2, _super);
          function Controller2() {
            return _super !== null && _super.apply(this, arguments) || this;
          }
          return Controller2;
        }(constructor);
      };
    }
  }();

  // ../../node_modules/@stimulus/core/dist/src/module.js
  var Module = function() {
    function Module2(application2, definition) {
      this.application = application2;
      this.definition = blessDefinition(definition);
      this.contextsByScope = new WeakMap();
      this.connectedContexts = new Set();
    }
    Object.defineProperty(Module2.prototype, "identifier", {
      get: function() {
        return this.definition.identifier;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Module2.prototype, "controllerConstructor", {
      get: function() {
        return this.definition.controllerConstructor;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Module2.prototype, "contexts", {
      get: function() {
        return Array.from(this.connectedContexts);
      },
      enumerable: true,
      configurable: true
    });
    Module2.prototype.connectContextForScope = function(scope) {
      var context2 = this.fetchContextForScope(scope);
      this.connectedContexts.add(context2);
      context2.connect();
    };
    Module2.prototype.disconnectContextForScope = function(scope) {
      var context2 = this.contextsByScope.get(scope);
      if (context2) {
        this.connectedContexts.delete(context2);
        context2.disconnect();
      }
    };
    Module2.prototype.fetchContextForScope = function(scope) {
      var context2 = this.contextsByScope.get(scope);
      if (!context2) {
        context2 = new Context(this, scope);
        this.contextsByScope.set(scope, context2);
      }
      return context2;
    };
    return Module2;
  }();

  // ../../node_modules/@stimulus/core/dist/src/data_map.js
  var DataMap = function() {
    function DataMap2(scope) {
      this.scope = scope;
    }
    Object.defineProperty(DataMap2.prototype, "element", {
      get: function() {
        return this.scope.element;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(DataMap2.prototype, "identifier", {
      get: function() {
        return this.scope.identifier;
      },
      enumerable: true,
      configurable: true
    });
    DataMap2.prototype.get = function(key) {
      key = this.getFormattedKey(key);
      return this.element.getAttribute(key);
    };
    DataMap2.prototype.set = function(key, value) {
      key = this.getFormattedKey(key);
      this.element.setAttribute(key, value);
      return this.get(key);
    };
    DataMap2.prototype.has = function(key) {
      key = this.getFormattedKey(key);
      return this.element.hasAttribute(key);
    };
    DataMap2.prototype.delete = function(key) {
      if (this.has(key)) {
        key = this.getFormattedKey(key);
        this.element.removeAttribute(key);
        return true;
      } else {
        return false;
      }
    };
    DataMap2.prototype.getFormattedKey = function(key) {
      return "data-" + this.identifier + "-" + dasherize(key);
    };
    return DataMap2;
  }();
  function dasherize(value) {
    return value.replace(/([A-Z])/g, function(_, char) {
      return "-" + char.toLowerCase();
    });
  }

  // ../../node_modules/@stimulus/core/dist/src/selectors.js
  function attributeValueContainsToken(attributeName, token) {
    return "[" + attributeName + '~="' + token + '"]';
  }

  // ../../node_modules/@stimulus/core/dist/src/target_set.js
  var TargetSet = function() {
    function TargetSet2(scope) {
      this.scope = scope;
    }
    Object.defineProperty(TargetSet2.prototype, "element", {
      get: function() {
        return this.scope.element;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(TargetSet2.prototype, "identifier", {
      get: function() {
        return this.scope.identifier;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(TargetSet2.prototype, "schema", {
      get: function() {
        return this.scope.schema;
      },
      enumerable: true,
      configurable: true
    });
    TargetSet2.prototype.has = function(targetName) {
      return this.find(targetName) != null;
    };
    TargetSet2.prototype.find = function() {
      var targetNames = [];
      for (var _i = 0; _i < arguments.length; _i++) {
        targetNames[_i] = arguments[_i];
      }
      var selector = this.getSelectorForTargetNames(targetNames);
      return this.scope.findElement(selector);
    };
    TargetSet2.prototype.findAll = function() {
      var targetNames = [];
      for (var _i = 0; _i < arguments.length; _i++) {
        targetNames[_i] = arguments[_i];
      }
      var selector = this.getSelectorForTargetNames(targetNames);
      return this.scope.findAllElements(selector);
    };
    TargetSet2.prototype.getSelectorForTargetNames = function(targetNames) {
      var _this = this;
      return targetNames.map(function(targetName) {
        return _this.getSelectorForTargetName(targetName);
      }).join(", ");
    };
    TargetSet2.prototype.getSelectorForTargetName = function(targetName) {
      var targetDescriptor = this.identifier + "." + targetName;
      return attributeValueContainsToken(this.schema.targetAttribute, targetDescriptor);
    };
    return TargetSet2;
  }();

  // ../../node_modules/@stimulus/core/dist/src/scope.js
  var Scope = function() {
    function Scope2(schema, identifier, element) {
      this.schema = schema;
      this.identifier = identifier;
      this.element = element;
      this.targets = new TargetSet(this);
      this.data = new DataMap(this);
    }
    Scope2.prototype.findElement = function(selector) {
      return this.findAllElements(selector)[0];
    };
    Scope2.prototype.findAllElements = function(selector) {
      var head = this.element.matches(selector) ? [this.element] : [];
      var tail = this.filterElements(Array.from(this.element.querySelectorAll(selector)));
      return head.concat(tail);
    };
    Scope2.prototype.filterElements = function(elements) {
      var _this = this;
      return elements.filter(function(element) {
        return _this.containsElement(element);
      });
    };
    Scope2.prototype.containsElement = function(element) {
      return element.closest(this.controllerSelector) === this.element;
    };
    Object.defineProperty(Scope2.prototype, "controllerSelector", {
      get: function() {
        return attributeValueContainsToken(this.schema.controllerAttribute, this.identifier);
      },
      enumerable: true,
      configurable: true
    });
    return Scope2;
  }();

  // ../../node_modules/@stimulus/core/dist/src/scope_observer.js
  var ScopeObserver = function() {
    function ScopeObserver2(element, schema, delegate) {
      this.element = element;
      this.schema = schema;
      this.delegate = delegate;
      this.valueListObserver = new ValueListObserver(this.element, this.controllerAttribute, this);
      this.scopesByIdentifierByElement = new WeakMap();
      this.scopeReferenceCounts = new WeakMap();
    }
    ScopeObserver2.prototype.start = function() {
      this.valueListObserver.start();
    };
    ScopeObserver2.prototype.stop = function() {
      this.valueListObserver.stop();
    };
    Object.defineProperty(ScopeObserver2.prototype, "controllerAttribute", {
      get: function() {
        return this.schema.controllerAttribute;
      },
      enumerable: true,
      configurable: true
    });
    ScopeObserver2.prototype.parseValueForToken = function(token) {
      var element = token.element, identifier = token.content;
      var scopesByIdentifier = this.fetchScopesByIdentifierForElement(element);
      var scope = scopesByIdentifier.get(identifier);
      if (!scope) {
        scope = new Scope(this.schema, identifier, element);
        scopesByIdentifier.set(identifier, scope);
      }
      return scope;
    };
    ScopeObserver2.prototype.elementMatchedValue = function(element, value) {
      var referenceCount = (this.scopeReferenceCounts.get(value) || 0) + 1;
      this.scopeReferenceCounts.set(value, referenceCount);
      if (referenceCount == 1) {
        this.delegate.scopeConnected(value);
      }
    };
    ScopeObserver2.prototype.elementUnmatchedValue = function(element, value) {
      var referenceCount = this.scopeReferenceCounts.get(value);
      if (referenceCount) {
        this.scopeReferenceCounts.set(value, referenceCount - 1);
        if (referenceCount == 1) {
          this.delegate.scopeDisconnected(value);
        }
      }
    };
    ScopeObserver2.prototype.fetchScopesByIdentifierForElement = function(element) {
      var scopesByIdentifier = this.scopesByIdentifierByElement.get(element);
      if (!scopesByIdentifier) {
        scopesByIdentifier = new Map();
        this.scopesByIdentifierByElement.set(element, scopesByIdentifier);
      }
      return scopesByIdentifier;
    };
    return ScopeObserver2;
  }();

  // ../../node_modules/@stimulus/core/dist/src/router.js
  var Router = function() {
    function Router2(application2) {
      this.application = application2;
      this.scopeObserver = new ScopeObserver(this.element, this.schema, this);
      this.scopesByIdentifier = new Multimap();
      this.modulesByIdentifier = new Map();
    }
    Object.defineProperty(Router2.prototype, "element", {
      get: function() {
        return this.application.element;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Router2.prototype, "schema", {
      get: function() {
        return this.application.schema;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Router2.prototype, "controllerAttribute", {
      get: function() {
        return this.schema.controllerAttribute;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Router2.prototype, "modules", {
      get: function() {
        return Array.from(this.modulesByIdentifier.values());
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Router2.prototype, "contexts", {
      get: function() {
        return this.modules.reduce(function(contexts, module) {
          return contexts.concat(module.contexts);
        }, []);
      },
      enumerable: true,
      configurable: true
    });
    Router2.prototype.start = function() {
      this.scopeObserver.start();
    };
    Router2.prototype.stop = function() {
      this.scopeObserver.stop();
    };
    Router2.prototype.loadDefinition = function(definition) {
      this.unloadIdentifier(definition.identifier);
      var module = new Module(this.application, definition);
      this.connectModule(module);
    };
    Router2.prototype.unloadIdentifier = function(identifier) {
      var module = this.modulesByIdentifier.get(identifier);
      if (module) {
        this.disconnectModule(module);
      }
    };
    Router2.prototype.getContextForElementAndIdentifier = function(element, identifier) {
      var module = this.modulesByIdentifier.get(identifier);
      if (module) {
        return module.contexts.find(function(context2) {
          return context2.element == element;
        });
      }
    };
    Router2.prototype.handleError = function(error2, message, detail) {
      this.application.handleError(error2, message, detail);
    };
    Router2.prototype.scopeConnected = function(scope) {
      this.scopesByIdentifier.add(scope.identifier, scope);
      var module = this.modulesByIdentifier.get(scope.identifier);
      if (module) {
        module.connectContextForScope(scope);
      }
    };
    Router2.prototype.scopeDisconnected = function(scope) {
      this.scopesByIdentifier.delete(scope.identifier, scope);
      var module = this.modulesByIdentifier.get(scope.identifier);
      if (module) {
        module.disconnectContextForScope(scope);
      }
    };
    Router2.prototype.connectModule = function(module) {
      this.modulesByIdentifier.set(module.identifier, module);
      var scopes = this.scopesByIdentifier.getValuesForKey(module.identifier);
      scopes.forEach(function(scope) {
        return module.connectContextForScope(scope);
      });
    };
    Router2.prototype.disconnectModule = function(module) {
      this.modulesByIdentifier.delete(module.identifier);
      var scopes = this.scopesByIdentifier.getValuesForKey(module.identifier);
      scopes.forEach(function(scope) {
        return module.disconnectContextForScope(scope);
      });
    };
    return Router2;
  }();

  // ../../node_modules/@stimulus/core/dist/src/schema.js
  var defaultSchema = {
    controllerAttribute: "data-controller",
    actionAttribute: "data-action",
    targetAttribute: "data-target"
  };

  // ../../node_modules/@stimulus/core/dist/src/application.js
  var __awaiter = function(thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function(resolve, reject) {
      function fulfilled(value) {
        try {
          step(generator.next(value));
        } catch (e) {
          reject(e);
        }
      }
      function rejected(value) {
        try {
          step(generator["throw"](value));
        } catch (e) {
          reject(e);
        }
      }
      function step(result) {
        result.done ? resolve(result.value) : new P(function(resolve2) {
          resolve2(result.value);
        }).then(fulfilled, rejected);
      }
      step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
  };
  var __generator = function(thisArg, body) {
    var _ = { label: 0, sent: function() {
      if (t[0] & 1)
        throw t[1];
      return t[1];
    }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() {
      return this;
    }), g;
    function verb(n) {
      return function(v) {
        return step([n, v]);
      };
    }
    function step(op) {
      if (f)
        throw new TypeError("Generator is already executing.");
      while (_)
        try {
          if (f = 1, y && (t = y[op[0] & 2 ? "return" : op[0] ? "throw" : "next"]) && !(t = t.call(y, op[1])).done)
            return t;
          if (y = 0, t)
            op = [0, t.value];
          switch (op[0]) {
            case 0:
            case 1:
              t = op;
              break;
            case 4:
              _.label++;
              return { value: op[1], done: false };
            case 5:
              _.label++;
              y = op[1];
              op = [0];
              continue;
            case 7:
              op = _.ops.pop();
              _.trys.pop();
              continue;
            default:
              if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) {
                _ = 0;
                continue;
              }
              if (op[0] === 3 && (!t || op[1] > t[0] && op[1] < t[3])) {
                _.label = op[1];
                break;
              }
              if (op[0] === 6 && _.label < t[1]) {
                _.label = t[1];
                t = op;
                break;
              }
              if (t && _.label < t[2]) {
                _.label = t[2];
                _.ops.push(op);
                break;
              }
              if (t[2])
                _.ops.pop();
              _.trys.pop();
              continue;
          }
          op = body.call(thisArg, _);
        } catch (e) {
          op = [6, e];
          y = 0;
        } finally {
          f = t = 0;
        }
      if (op[0] & 5)
        throw op[1];
      return { value: op[0] ? op[1] : void 0, done: true };
    }
  };
  var Application = function() {
    function Application2(element, schema) {
      if (element === void 0) {
        element = document.documentElement;
      }
      if (schema === void 0) {
        schema = defaultSchema;
      }
      this.element = element;
      this.schema = schema;
      this.dispatcher = new Dispatcher(this);
      this.router = new Router(this);
    }
    Application2.start = function(element, schema) {
      var application2 = new Application2(element, schema);
      application2.start();
      return application2;
    };
    Application2.prototype.start = function() {
      return __awaiter(this, void 0, void 0, function() {
        return __generator(this, function(_a) {
          switch (_a.label) {
            case 0:
              return [4, domReady()];
            case 1:
              _a.sent();
              this.router.start();
              this.dispatcher.start();
              return [2];
          }
        });
      });
    };
    Application2.prototype.stop = function() {
      this.router.stop();
      this.dispatcher.stop();
    };
    Application2.prototype.register = function(identifier, controllerConstructor) {
      this.load({ identifier, controllerConstructor });
    };
    Application2.prototype.load = function(head) {
      var _this = this;
      var rest = [];
      for (var _i = 1; _i < arguments.length; _i++) {
        rest[_i - 1] = arguments[_i];
      }
      var definitions = Array.isArray(head) ? head : [head].concat(rest);
      definitions.forEach(function(definition) {
        return _this.router.loadDefinition(definition);
      });
    };
    Application2.prototype.unload = function(head) {
      var _this = this;
      var rest = [];
      for (var _i = 1; _i < arguments.length; _i++) {
        rest[_i - 1] = arguments[_i];
      }
      var identifiers = Array.isArray(head) ? head : [head].concat(rest);
      identifiers.forEach(function(identifier) {
        return _this.router.unloadIdentifier(identifier);
      });
    };
    Object.defineProperty(Application2.prototype, "controllers", {
      get: function() {
        return this.router.contexts.map(function(context2) {
          return context2.controller;
        });
      },
      enumerable: true,
      configurable: true
    });
    Application2.prototype.getControllerForElementAndIdentifier = function(element, identifier) {
      var context2 = this.router.getContextForElementAndIdentifier(element, identifier);
      return context2 ? context2.controller : null;
    };
    Application2.prototype.handleError = function(error2, message, detail) {
      console.error("%s\n\n%o\n\n%o", message, error2, detail);
    };
    return Application2;
  }();
  function domReady() {
    return new Promise(function(resolve) {
      if (document.readyState == "loading") {
        document.addEventListener("DOMContentLoaded", resolve);
      } else {
        resolve();
      }
    });
  }

  // ../../node_modules/@stimulus/core/dist/src/target_properties.js
  function defineTargetProperties(constructor) {
    var prototype = constructor.prototype;
    var targetNames = getTargetNamesForConstructor(constructor);
    targetNames.forEach(function(name) {
      var _a;
      return defineLinkedProperties(prototype, (_a = {}, _a[name + "Target"] = {
        get: function() {
          var target = this.targets.find(name);
          if (target) {
            return target;
          } else {
            throw new Error('Missing target element "' + this.identifier + "." + name + '"');
          }
        }
      }, _a[name + "Targets"] = {
        get: function() {
          return this.targets.findAll(name);
        }
      }, _a["has" + capitalize(name) + "Target"] = {
        get: function() {
          return this.targets.has(name);
        }
      }, _a));
    });
  }
  function getTargetNamesForConstructor(constructor) {
    var ancestors = getAncestorsForConstructor(constructor);
    return Array.from(ancestors.reduce(function(targetNames, constructor2) {
      getOwnTargetNamesForConstructor(constructor2).forEach(function(name) {
        return targetNames.add(name);
      });
      return targetNames;
    }, new Set()));
  }
  function getAncestorsForConstructor(constructor) {
    var ancestors = [];
    while (constructor) {
      ancestors.push(constructor);
      constructor = Object.getPrototypeOf(constructor);
    }
    return ancestors;
  }
  function getOwnTargetNamesForConstructor(constructor) {
    var definition = constructor["targets"];
    return Array.isArray(definition) ? definition : [];
  }
  function defineLinkedProperties(object, properties) {
    Object.keys(properties).forEach(function(name) {
      if (!(name in object)) {
        var descriptor = properties[name];
        Object.defineProperty(object, name, descriptor);
      }
    });
  }
  function capitalize(name) {
    return name.charAt(0).toUpperCase() + name.slice(1);
  }

  // ../../node_modules/@stimulus/core/dist/src/controller.js
  var Controller = function() {
    function Controller2(context2) {
      this.context = context2;
    }
    Controller2.bless = function() {
      defineTargetProperties(this);
    };
    Object.defineProperty(Controller2.prototype, "application", {
      get: function() {
        return this.context.application;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Controller2.prototype, "scope", {
      get: function() {
        return this.context.scope;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Controller2.prototype, "element", {
      get: function() {
        return this.scope.element;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Controller2.prototype, "identifier", {
      get: function() {
        return this.scope.identifier;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Controller2.prototype, "targets", {
      get: function() {
        return this.scope.targets;
      },
      enumerable: true,
      configurable: true
    });
    Object.defineProperty(Controller2.prototype, "data", {
      get: function() {
        return this.scope.data;
      },
      enumerable: true,
      configurable: true
    });
    Controller2.prototype.initialize = function() {
    };
    Controller2.prototype.connect = function() {
    };
    Controller2.prototype.disconnect = function() {
    };
    Controller2.targets = [];
    return Controller2;
  }();

  // ../../node_modules/@stimulus/webpack-helpers/dist/index.js
  function definitionsFromContext(context2) {
    return context2.keys().map(function(key) {
      return definitionForModuleWithContextAndKey(context2, key);
    }).filter(function(value) {
      return value;
    });
  }
  function definitionForModuleWithContextAndKey(context2, key) {
    var identifier = identifierForContextKey(key);
    if (identifier) {
      return definitionForModuleAndIdentifier(context2(key), identifier);
    }
  }
  function definitionForModuleAndIdentifier(module, identifier) {
    var controllerConstructor = module.default;
    if (typeof controllerConstructor == "function") {
      return { identifier, controllerConstructor };
    }
  }
  function identifierForContextKey(key) {
    var logicalName = (key.match(/^(?:\.\/)?(.+)(?:[_-]controller\..+?)$/) || [])[1];
    if (logicalName) {
      return logicalName.replace(/_/g, "-").replace(/\//g, "--");
    }
  }

  // application.js
  require_rails_ujs().start();
  require_turbolinks().start();
  var application = Application.start();
  var context = __require.context("controllers", true, /.js$/);
  application.load(definitionsFromContext(context));
})();
