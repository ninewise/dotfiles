say "Running mbsync..."
if not system "mbsync", "-a", "-qq"
  say "mbsync unsuccesful."
end
