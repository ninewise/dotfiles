#!/usr/bin/python

config.backend = "webengine"
config.load_autoconfig = False
c.completion.shrink = True
c.confirm_quit = ["downloads"]
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
c.url.searchengines = { "startpage": "https://startpage.com/do/search?query={}"
                      , "ecosia": "https://www.ecosia.org/search?q={}"
                      , "DEFAULT": "https://3g2upl4pq6kufc4m.onion/html?q={}" # ddg
                      , "framabee": "https://framabee.org/?q={}"
                      , "invidious": "http://axqzx4s6s54s32yentfqojs3x5i7faxza6xo3ehd4bzzsg2ii4fv2iid.onion/search?q={}"
                      }

# Privacy
c.content.proxy = "socks://localhost:9050"
c.content.javascript.enabled = False
c.content.canvas_reading = False # https://en.wikipedia.org/wiki/Canvas_fingerprinting
c.content.webgl = False # https://browserleaks.com/webgl
c.content.ssl_strict = True
c.content.headers.accept_language = "en-US,en;q=0.5"
c.content.headers.custom = { "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" }
c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"
c.content.webrtc_ip_handling_policy = "default-public-interface-only"
c.content.cookies.accept = "no-3rdparty"

# Aliases
c.aliases = { "wq": "quit --save"
            , "set": "set -t"
            , "quickmarks": "open qute://bookmarks/"
            }

# Bindings
config.bind("<backspace>", "back", mode="normal")
config.bind("x", "spawn --detach mpv {url}", mode="normal")
config.bind(";x", "hint links spawn --detach mpv {hint-url}", mode="normal")
config.bind("<Alt+j>", "prompt-item-focus next", mode="prompt")
config.bind("<Alt+k>", "prompt-item-focus prev", mode="prompt")
config.bind("<Alt+l>", "fake-key -g /", mode="prompt")
config.bind("<Alt+h>", "rl-unix-filename-rubout", mode="prompt")

# I don't use bookmarks
config.unbind('wB')
config.unbind('gb')
config.unbind('gB')
config.unbind('Sb')

# Allowing javascript for...
allowed = [ 'https://duckduckgo.com/*'
          , 'https://www.facebookcorewwwi.onion/*'
          , 'https://github.com/*'
          , 'https://*.ugent.be/*'
          , 'https://secure.ogone.com/*'                 # bancontact
          , 'https://belgium-3dsecure.wlp-acs.com/*'     # bancontact
          , 'https://bcr.girogate.be/*'                  # bancontact
          , 'https://bancontact.girogate.be/*'           # bancontact
          , 'https://belgium-uvj-3dsecure.wlp-acs.com/*' # bancontact
          , 'https://*.triodos.be/*'
          , 'https://www.openstreetmap.org/*'
          , 'https://web.whatsapp.com'
          , 'https://chat.zeus.gent/*'
          , 'https://mattermost.zeus.gent/*'
          , 'https://posteo.de/*'
          , 'https://doc.rust-lang.org/*'
          , 'https://www.paypal.com/*'
          , 'https://www.paypal-topup.be/*'
          , 'https://homebank.argenta.be/*'
          ]

for pattern in allowed:
    config.set('content.javascript.enabled', True, pattern)
