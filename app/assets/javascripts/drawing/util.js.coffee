$ ->

  window.pretty_print = (obj) ->
    return JSON.stringify(obj, undefined, 2)

  window.show = (el, to_show) ->
    if to_show == true
      el.show
    else if to_show == false
      el.hide

  (($) ->
    $.fn.visible = (to_show) ->
      console.log("to_show = #{to_show}")
      if to_show == true
        this.show
      else if to_show == false
        this.hide
      return
    ) jQuery
