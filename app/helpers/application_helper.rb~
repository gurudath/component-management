module ApplicationHelper

DEFAULT_ARGUMENTS={
 :decoration=>"/decoration/decoration",
 :partial=>"/decoration/index"
}

  def render_template_in_format(args={})
        args =  (DEFAULT_ARGUMENTS).merge(args)
         unless args[:partial].blank?
           begin
             args[:header_include] = (args[:header_include].blank? ? args[:object].first.class.column_names : args[:header_include]) unless args[:object].blank?
             value = (render :partial=>args[:partial] , locals: args,:layout=>args[:decoration])
           rescue => e
               logger.error e.message
               logger.error e.backtrace.join("\n") 
               puts e.message
               puts  e.backtrace.join("\n")
              "Information Correctly Not Availiable"
           end
         end
  end

 def highlight_text(query,field)
  @results= results = Article.search do
    fulltext query do
      highlight field.to_sym
    end
  end
  content = ""
  @results.hits.each do |hit|
   puts "Post ##{hit.primary_key}"
   hit.highlights(field.to_sym).each do |highlight|
    content = highlight.format { |word| "<span class=highlite_text>#{word}</span>" }
   end
  end
  return content
end


end
