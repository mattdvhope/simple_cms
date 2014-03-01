module ApplicationHelper

  def error_messages_for(object) # will be used in views/subjects/_form.html.erb
    render(partial: 'application/error_messages', locals: {object: object}) # This object will be passed along to the partial; the key, object:, will be what the partial uses as its 'object'
  end

  def status_tag(boolean, options={}) #this method will be used in views/subjects/index.html.erb
    options[:true_text]  ||= ''
    options[:false_text] ||= ''
    
    if boolean #in views/subjects/index.html.erb, if 'subjects.visible' is a boolean, it will return a span tag of true; otherwise, it will return a span tag of false which would be ''
      content_tag(:span, options[:true_text], :class => 'status true') #content_tag is an html helper; in this case, it generate a <span> tag for me and will put into that span tag what the text for true or false is; if it's false, it will be nothing b/c of the ||= operator; then that span tag will get a status of true (or false for 'else')
    else
      content_tag(:span, options[:false_text], :class => 'status false')
    end
  end

end
