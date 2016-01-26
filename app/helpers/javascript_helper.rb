module JavascriptHelper
  def replace_using_partial(target_selector, partial, locals = nil)
    return raw("$(\"#{target_selector}\").html(\"#{ escape_javascript(render partial: partial, locals: locals) }\");")
  end
end