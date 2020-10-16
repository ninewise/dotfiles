#!/usr/bin/python

from qutebrowser.api import interceptor
from PyQt5.QtCore import QUrl, QUrlQuery

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
                      , "qwant": "https://lite.qwant.com/?q={}"
                      , "cliqz": "https://beta.cliqz.com/search?q={}" # discontinued
                      , "duckduckgo": "https://duckduckgo.com/html?q={}"
                      , "duckduckgonion": "https://3g2upl4pq6kufc4m.onion/html?q={}"
                      , "framabee": "https://framabee.org/?q={}"
                      , "invidious": "http://c7hqkpkpemu6e7emz5b4vyz7idjgdvgaaa3dyimmeojqbgpea3xqjoid.onion/search?q={}"
                      , "invidious-untor": "https://invidious.snopyta.org/search?q={}"
                      , "openstreetmap": "https://www.openstreetmap.org/search?query={}"
                      , "wikipedia": "https://en.wikipedia.org/w/index.php?search={}"
                      , "wikipedia/nl": "https://nl.wikipedia.org/w/index.php?search={}"
                      , "hoogle": "https://hoogle.haskell.org/?hoogle={}"
                      , "snopyta": "http://juy4e6eicawzdrz7.onion/?q={}"
                      , "DEFAULT": "http://juy4e6eicawzdrz7.onion/?q={}"
                      , "telefoonboek": "https://telefoonboek.ugent.be/nl/simple?name={}"
                      }

# Privacy
c.content.proxy = "socks://localhost:9050"
c.content.javascript.enabled = False
c.content.canvas_reading = False # https://en.wikipedia.org/wiki/Canvas_fingerprinting
c.content.webgl = False # https://browserleaks.com/webgl
c.content.ssl_strict = True
c.content.headers.accept_language = "en-US,en;q=0.5"
c.content.headers.custom = { "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" }
c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36"
c.content.webrtc_ip_handling_policy = "default-public-interface-only"

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
config.bind("o", "set-cmd-text -s :open -s ", mode="normal")
config.bind("O", "set-cmd-text -s :open -s -t ", mode="normal")
config.bind("\\", "set-cmd-text -s :open ", mode="normal")
config.bind("|", "set-cmd-text -s :open -t ", mode="normal")

# I don't use bookmarks
config.unbind('wB')
config.unbind('gb')
config.unbind('gB')
config.unbind('Sb')

# Allowing javascript for...
allowed = [ 'https://duckduckgo.com/*'
          , 'https://github.com/*'
          , 'https://*.ugent.be/*'
          , 'https://secure.ogone.com/*'                 # bancontact
          , 'https://belgium-3dsecure.wlp-acs.com/*'     # bancontact
          , 'https://belgium-3ds.wlp-acs.com/*'          # bancontact
          , 'https://bcr.girogate.be/*'                  # bancontact
          , 'https://bancontact.girogate.be/*'           # bancontact
          , 'https://belgium-uvj-3dsecure.wlp-acs.com/*' # bancontact
          , 'https://*.triodos.be/*'
          , 'https://www.openstreetmap.org/*'
          , 'https://mattermost.zeus.gent/*'
          , 'https://posteo.de/*'
          , 'https://doc.rust-lang.org/*'
          , 'https://www.paypal.com/*'
          , 'https://www.paypal-topup.be/*'
          , 'https://homebank.argenta.be/*'
          ]

for pattern in allowed:
    config.set('content.javascript.enabled', True, pattern)

# Allowing cookies for...
c.content.cookies.accept = "never"
allowed = [ 'https://github.com/*'
          , 'https://*.ugent.be/*'
          , 'https://*.triodos.be/*'
          , 'https://mattermost.zeus.gent/*'
          , 'https://posteo.de/*'
          , 'https://homebank.argenta.be/*'
          , 'https://*.facebookcorewwwi.onion/*'
          ]
for pattern in allowed:
    config.set('content.cookies.accept', "no-3rdparty", pattern)

# Some redirects
redirects = { 'www.reddit.com': 'old.reddit.com'
            , 'www.youtube.com': 'c7hqkpkpemu6e7emz5b4vyz7idjgdvgaaa3dyimmeojqbgpea3xqjoid.onion'
            , 'www.youtube.be': 'c7hqkpkpemu6e7emz5b4vyz7idjgdvgaaa3dyimmeojqbgpea3xqjoid.onion'
            , 'youtu.be': 'c7hqkpkpemu6e7emz5b4vyz7idjgdvgaaa3dyimmeojqbgpea3xqjoid.onion'
            , 'twitter.com': 'nitter.net'
            }

def intercept(info: interceptor.Request) -> None:
    if new_host := redirects.get(info.request_url.host()):
        new_url = QUrl(info.request_url)
        new_url.setHost(new_host)
        if info.request_url.scheme() == 'https' and new_host.endswith('.onion'):
            new_url.setScheme('http')
        info.redirect(new_url)

    elif 'juy4e6eicawzdrz7.onion' == info.request_url.host() and 'https' == info.request_url.scheme():
        new_url = QUrl(info.request_url)
        new_url.setScheme('http')
        info.redirect(new_url)

interceptor.register(intercept)
