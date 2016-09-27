(function () {
  'use strict';

  setupAnimations();

  Reveal.addEventListener('slidechanged', function(evt) {
    var animation = evt.currentSlide.querySelector('[data-svg-animation]');
    if (animation) {
      animation.animateSvg && animation.animateSvg();
    }
  });

  function setupAnimations() {
    var animationElements =
        [].slice.call(document.querySelectorAll('[data-svg-animation]'));
    animationElements.forEach(function (element) {
      element.animateSvg = function () {
        animatePaths(element, this.dataset.svgAnimation);
      };
    });
  }

  function animatePaths(element, configWrapperId) {
    var configWrapper = document.getElementById(configWrapperId);
    if (!configWrapper) { return; }

    var configContents = configWrapper.innerHTML.trim();
    var config = JSON.parse(configContents);
    var waitOffset = 0;
    config.forEach(function (directive) {
      if (directive.wait) {
        waitOffset += directive.wait;
      }
      var selector = directive.el;
      if (selector) {
        var animationLength = directive.length || 0.4;
        var svg = element.contentDocument.documentElement;
        var paths = [].slice.call(svg.querySelectorAll(selector));
        var startGroupDelay = waitOffset;
        if (directive.simultaneously) {
          waitOffset += animationLength;
        }
        paths.forEach(function (path) {
          if (typeof path.getTotalLength === 'function') {
            var length = path.getTotalLength();
            path.style.transition = 'none';
            path.style.strokeDasharray = length + ' ' + length;
            path.style.strokeDashoffset = length;
            path.getBoundingClientRect();
            path.style.transition = 'stroke-dashoffset ' +
              animationLength + 's ease-in-out ' +
              (directive.simultaneously ? startGroupDelay : waitOffset) + 's';
            path.style.strokeDashoffset = 0;
          }
          else {
            path.style.transition = 'none';
            path.style.opacity = 0;
            path.getBoundingClientRect();
            path.style.transition = 'opacity ' +
              animationLength + 's ease-in-out ' +
              (directive.simultaneously ? startGroupDelay : waitOffset) + 's';
            path.style.opacity = 1;
          }
          if (!directive.simultaneously) {
            waitOffset += animationLength;
          }
        });
      }
    });
  }
}());
