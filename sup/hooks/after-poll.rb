
if num_inbox > 0
  system "notify-send", \
    "#{num_inbox_total_unread} unread messages (#{num_inbox} new)", \
    from_and_subj_inbox.map {|p| "#{p[0]} - #{p[1]}"}.join("\n")
end
