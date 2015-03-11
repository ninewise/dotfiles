require 'shellwords'
unless sibling_types.member? "text/plain"
  case content_type
  when "text/html"
    `/usr/bin/w3m -dump -T #{content_type} #{Shellwords.escape filename}`
  end
end
