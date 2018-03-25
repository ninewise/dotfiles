#!/usr/bin/python

config.backend = "webengine"
config.load_autoconfig = False

c.completion.shrink = True
c.confirm_quit = ["downloads"]
# c.content.developer_extras = True
c.content.javascript.enabled = False
c.content.ssl_strict = True
c.content.headers.accept_language = "en-US"
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
c.url.default_page = "https://calendar.google.com"
c.url.start_pages = ["https://calendar.google.com"]
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
config.unbind('M')
config.unbind('wB')
config.unbind('gb')
config.unbind('gB')
config.unbind('Sb')

# Allowing javascript for...
allowed = [ 'https://calendar.google.com/*'
          , 'https://www.facebook.com/*'
          , 'https://www.glowing-bear.org/*'
          , 'https://zeuswpi.slack.com/*'
          , 'https://github.com/*'
          , 'https://*.ugent.be/*'
          , 'https://secure.ogone.com/*'             # bancontact
          , 'https://belgium-3dsecure.wlp-acs.com/*' # bancontact
          , 'https://*.axabank.be/*'
          ]

for pattern in allowed:
    config.set('content.javascript.enabled', True, pattern)
