#!/usr/bin/python

config.backend = "webengine"
config.load_autoconfig = False

# c.qt.force_software_rendering = "software-opengl"

c.completion.shrink = True
c.confirm_quit = ["downloads"]
# c.content.developer_extras = True
c.content.proxy = "socks://localhost:9050"
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
          , 'https://calendar.google.com/*'
          , 'https://www.facebook.com/*'
          , 'https://www.glowing-bear.org/*'
          , 'https://github.com/*'
          , 'https://*.ugent.be/*'
          , 'https://secure.ogone.com/*'             # bancontact
          , 'https://belgium-3dsecure.wlp-acs.com/*' # bancontact
          , 'https://bcr.girogate.be/*'              # bancontact
          , 'https://*.axabank.be/*'
          , 'https://*.triodos.be/*'
          , 'https://*.ing.be/*'
          , 'https://accounts.google.com/*'
          , 'https://www.openstreetmap.org/*'
          , 'https://web.whatsapp.com'
          , 'https://chat.zeus.gent/*'
          , 'https://mattermost.zeus.gent/*'
          , 'https://posteo.de/*'
          , 'https://doc.rust-lang.org/*'
          ]

for pattern in allowed:
    config.set('content.javascript.enabled', True, pattern)
