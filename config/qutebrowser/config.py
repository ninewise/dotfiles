#!/usr/bin/python

config.backend = "webengine"
config.load_autoconfig = False

c.completion.shrink = True
c.confirm_quit = ["downloads"]
# c.content.developer_extras = True
c.content.javascript.enabled = False
c.content.ssl_strict = True
c.content.headers.accept_language = "en-US,en;q=0.5"
c.content.headers.custom = { "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" }
c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
c.downloads.location.directory = "/data/temporary"
c.downloads.location.suggestion = "both"
c.downloads.open_dispatcher = "rifle"
c.editor.command = ["st", "-e", "vis", "{}"]
c.hints.auto_follow = "full-match"
c.hints.dictionary = "/usr/share/dict/mnemonic"
c.hints.mode = "word"
c.new_instance_open_target = "tab-silent"
c.session.default_name = "default"
c.tabs.background = True
c.tabs.last_close = "close"
c.tabs.show = "multiple"
c.url.default_page = "about:blank"
c.url.start_pages = ["qute://bookmarks"]
c.aliases = { "wq": "quit --save"
            , "set": "set -t"
            , "bind": "bind -t"
            , "quickmarks": "open qute://bookmarks/"
            }

config.bind("<backspace>", "back", mode="normal")
config.bind("x", "spawn --detach mpv {url}", mode="normal")
config.bind(";x", "hint links spawn --detach mpv {hint-url}", mode="normal")
config.bind("si", "jseval --quiet --file simplyread.js", mode="normal")
config.bind("z", 'enter-mode insert ;; \
                  jseval --quiet \
                      var inputs = document.getElementsByTagName("input"); \
                      for(var i = 0; i < inputs.length; i++) { \
                          var hidden = false; \
                          for(var j = 0; j < inputs[i].attributes.length; j++) { \
                              hidden = hidden || inputs[i].attributes[j].value.includes("hidden"); \
                          }; \
                          if(!hidden) { \
                              inputs[i].focus(); \
                              break; \
                          } \
                      }', mode="normal")

# I don't use bookmarks
config.unbind('wB')
config.unbind('gb')
config.unbind('gB')
config.unbind('Sb')

# Allowing javascript for...
allowed = [ 'https://duckduckgo.com/*'
          , 'https://calendar.google.com/*'
          , 'https://www.facebook.com/*'
          , 'https://www.glowing-bear.org/*'
          , 'https://zeuswpi.slack.com/*'
          , 'https://github.com/*'
          , 'https://*.ugent.be/*'
          , 'https://secure.ogone.com/*'             # bancontact
          , 'https://belgium-3dsecure.wlp-acs.com/*' # bancontact
          , 'https://*.axabank.be/*'
          , 'https://*.ing.be/*'
          , 'https://accounts.google.com/*'
          , 'https://www.openstreetmap.org/*'
          , 'https://web.whatsapp.com'
          , 'https://chat.zeus.gent/*'
          , 'https://posteo.de/*'
          ]

for pattern in allowed:
    config.set('content.javascript.enabled', True, pattern)
