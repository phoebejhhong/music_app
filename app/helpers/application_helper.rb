module ApplicationHelper

  def ugly_lyrics(lyrics)
    result = ""
    lyrics.split("\n").each do |line|
      result += "&#9835; "
      result += h(line)
    end

    "<pre>#{result}</pre>".html_safe
  end
end
