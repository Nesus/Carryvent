jQuery.easing.jswing = jQuery.easing.swing
jQuery.extend jQuery.easing,
  def: "easeOutQuad"
  swing: (e, f, a, h, g) ->
    jQuery.easing[jQuery.easing.def] e, f, a, h, g

  easeInQuad: (e, f, a, h, g) ->
    h * (f /= g) * f + a

  easeOutQuad: (e, f, a, h, g) ->
    -h * (f /= g) * (f - 2) + a

  easeInOutQuad: (e, f, a, h, g) ->
    return h / 2 * f * f + a  if (f /= g / 2) < 1
    -h / 2 * ((--f) * (f - 2) - 1) + a

  easeInCubic: (e, f, a, h, g) ->
    h * (f /= g) * f * f + a

  easeOutCubic: (e, f, a, h, g) ->
    h * ((f = f / g - 1) * f * f + 1) + a

  easeInOutCubic: (e, f, a, h, g) ->
    return h / 2 * f * f * f + a  if (f /= g / 2) < 1
    h / 2 * ((f -= 2) * f * f + 2) + a

  easeInQuart: (e, f, a, h, g) ->
    h * (f /= g) * f * f * f + a

  easeOutQuart: (e, f, a, h, g) ->
    -h * ((f = f / g - 1) * f * f * f - 1) + a

  easeInOutQuart: (e, f, a, h, g) ->
    return h / 2 * f * f * f * f + a  if (f /= g / 2) < 1
    -h / 2 * ((f -= 2) * f * f * f - 2) + a

  easeInQuint: (e, f, a, h, g) ->
    h * (f /= g) * f * f * f * f + a

  easeOutQuint: (e, f, a, h, g) ->
    h * ((f = f / g - 1) * f * f * f * f + 1) + a

  easeInOutQuint: (e, f, a, h, g) ->
    return h / 2 * f * f * f * f * f + a  if (f /= g / 2) < 1
    h / 2 * ((f -= 2) * f * f * f * f + 2) + a

  easeInSine: (e, f, a, h, g) ->
    -h * Math.cos(f / g * (Math.PI / 2)) + h + a

  easeOutSine: (e, f, a, h, g) ->
    h * Math.sin(f / g * (Math.PI / 2)) + a

  easeInOutSine: (e, f, a, h, g) ->
    -h / 2 * (Math.cos(Math.PI * f / g) - 1) + a

  easeInExpo: (e, f, a, h, g) ->
    (if (f is 0) then a else h * Math.pow(2, 10 * (f / g - 1)) + a)

  easeOutExpo: (e, f, a, h, g) ->
    (if (f is g) then a + h else h * (-Math.pow(2, -10 * f / g) + 1) + a)

  easeInOutExpo: (e, f, a, h, g) ->
    return a  if f is 0
    return a + h  if f is g
    return h / 2 * Math.pow(2, 10 * (f - 1)) + a  if (f /= g / 2) < 1
    h / 2 * (-Math.pow(2, -10 * --f) + 2) + a

  easeInCirc: (e, f, a, h, g) ->
    -h * (Math.sqrt(1 - (f /= g) * f) - 1) + a

  easeOutCirc: (e, f, a, h, g) ->
    h * Math.sqrt(1 - (f = f / g - 1) * f) + a

  easeInOutCirc: (e, f, a, h, g) ->
    return -h / 2 * (Math.sqrt(1 - f * f) - 1) + a  if (f /= g / 2) < 1
    h / 2 * (Math.sqrt(1 - (f -= 2) * f) + 1) + a

  easeInElastic: (f, h, e, l, k) ->
    i = 1.70158
    j = 0
    g = l
    return e  if h is 0
    return e + l  if (h /= k) is 1
    j = k * 0.3  unless j
    if g < Math.abs(l)
      g = l
      i = j / 4
    else
      i = j / (2 * Math.PI) * Math.asin(l / g)
    -(g * Math.pow(2, 10 * (h -= 1)) * Math.sin((h * k - i) * (2 * Math.PI) / j)) + e

  easeOutElastic: (f, h, e, l, k) ->
    i = 1.70158
    j = 0
    g = l
    return e  if h is 0
    return e + l  if (h /= k) is 1
    j = k * 0.3  unless j
    if g < Math.abs(l)
      g = l
      i = j / 4
    else
      i = j / (2 * Math.PI) * Math.asin(l / g)
    g * Math.pow(2, -10 * h) * Math.sin((h * k - i) * (2 * Math.PI) / j) + l + e

  easeInOutElastic: (f, h, e, l, k) ->
    i = 1.70158
    j = 0
    g = l
    return e  if h is 0
    return e + l  if (h /= k / 2) is 2
    j = k * (0.3 * 1.5)  unless j
    if g < Math.abs(l)
      g = l
      i = j / 4
    else
      i = j / (2 * Math.PI) * Math.asin(l / g)
    return -0.5 * (g * Math.pow(2, 10 * (h -= 1)) * Math.sin((h * k - i) * (2 * Math.PI) / j)) + e  if h < 1
    g * Math.pow(2, -10 * (h -= 1)) * Math.sin((h * k - i) * (2 * Math.PI) / j) * 0.5 + l + e

  easeInBack: (e, f, a, i, h, g) ->
    g = 1.70158  if g is `undefined`
    i * (f /= h) * f * ((g + 1) * f - g) + a

  easeOutBack: (e, f, a, i, h, g) ->
    g = 1.70158  if g is `undefined`
    i * ((f = f / h - 1) * f * ((g + 1) * f + g) + 1) + a

  easeInOutBack: (e, f, a, i, h, g) ->
    g = 1.70158  if g is `undefined`
    return i / 2 * (f * f * (((g *= (1.525)) + 1) * f - g)) + a  if (f /= h / 2) < 1
    i / 2 * ((f -= 2) * f * (((g *= (1.525)) + 1) * f + g) + 2) + a

  easeInBounce: (e, f, a, h, g) ->
    h - jQuery.easing.easeOutBounce(e, g - f, 0, h, g) + a

  easeOutBounce: (e, f, a, h, g) ->
    if (f /= g) < (1 / 2.75)
      h * (7.5625 * f * f) + a
    else
      if f < (2 / 2.75)
        h * (7.5625 * (f -= (1.5 / 2.75)) * f + 0.75) + a
      else
        if f < (2.5 / 2.75)
          h * (7.5625 * (f -= (2.25 / 2.75)) * f + 0.9375) + a
        else
          h * (7.5625 * (f -= (2.625 / 2.75)) * f + 0.984375) + a

  easeInOutBounce: (e, f, a, h, g) ->
    return jQuery.easing.easeInBounce(e, f * 2, 0, h, g) * 0.5 + a  if f < g / 2
    jQuery.easing.easeOutBounce(e, f * 2 - g, 0, h, g) * 0.5 + h * 0.5 + a

$ ->
  $("a.page-scroll").bind "click", (event) ->
    $anchor = $(this)
    $("html, body").stop().animate
      scrollTop: $($anchor.attr("href")).offset().top
    , 1500, "easeInOutExpo"
    event.preventDefault()
    return

  return
