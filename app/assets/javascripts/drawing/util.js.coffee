$ ->

  window.pretty_print = (obj) ->
    return JSON.stringify(obj, undefined, 2)

  (($) ->
    $.fn.visible = (to_show) ->
      console.log("to_show = #{to_show}")
      console.log(this)
      if to_show == true
        this.show()
      else if to_show == false
        this.hide()
      return
    ) jQuery
