#!/usr/bin/python

from qutebrowser.api import interceptor
from PyQt5.QtCore import QUrl, QUrlQuery
from unalix import clear_url

config.backend = "webengine"
config.load_autoconfig(False)
c.completion.shrink = True
c.confirm_quit = ["downloads"]
c.downloads.location.directory = "/tmp"
c.downloads.location.suggestion = "both"
c.downloads.open_dispatcher = "rifle"
c.editor.command = ["st", "-e", "vis", "{}"]
c.fileselect.handler = "external"
c.fileselect.multiple_files.command = ["st", "-e", "ranger", "--choosefiles={}"]
c.fileselect.single_file.command = ["st", "-e", "ranger", "--choosefile={}"]
c.hints.auto_follow = "full-match"
c.hints.dictionary = "/usr/share/dict/mnemonic"
c.hints.mode = "word"
c.new_instance_open_target = "tab-silent"
c.session.default_name = "default"
c.tabs.background = True
c.tabs.last_close = "close"
c.tabs.show = "multiple"
c.tabs.favicons.show = "never"
c.url.default_page = "about:blank"
c.url.start_pages = ["qute://bookmarks"]
c.url.searchengines = { "startpage": "https://startpage.com/do/search?query={}"
                      , "ecosia": "https://www.ecosia.org/search?q={}"
                      , "qwant": "https://lite.qwant.com/?q={}"
                      , "cliqz": "https://beta.cliqz.com/search?q={}" # discontinued
                      , "duckduckgo": "https://duckduckgo.com/html?q={}"
                      , "framabee": "https://framabee.org/?q={}"
                      , "invidious": "http://c7hqkpkpemu6e7emz5b4vyz7idjgdvgaaa3dyimmeojqbgpea3xqjoid.onion/search?q={}"
                      , "invidious-untor": "https://invidious.snopyta.org/search?q={}"
                      , "openstreetmap": "https://www.openstreetmap.org/search?query={}"
                      , "wikipedia": "https://en.wikipedia.org/w/index.php?search={}"
                      , "wikipedia/nl": "https://nl.wikipedia.org/w/index.php?search={}"
                      , "hoogle": "https://hoogle.haskell.org/?hoogle={}"
                      , "snopyta": "http://juy4e6eicawzdrz7.onion/?q={}"
                      , "telefoonboek": "https://telefoonboek.ugent.be/nl/simple?name={}"
                      , "prvcy": "http://hmfztxt3pfhevucl.onion/?q={}"
                      , "wiktionary": "https://en.wiktionary.org/w/index.php?search={}"
                      , "monicz.pl": "http://upzhip7hatfbsi5xcwyw6n2bpappt3j4gkvwjmyb7qo6urcyhmlekpad.onion/?q={}"
                      , "trantor": "http://kx5thpx2olielkihfyo4jgjqfb7zx7wxr3sd4xzt26ochei4m6f7tayd.onion/search/?q={}"
                      , "duckduckgonion": "https://duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion/html?q={}"
                      , "mellowchan": "https://srx.mellowchan.xyz/?q={}"
                      , "DEFAULT": "https://srx.mellowchan.xyz/?q={}"
                      }
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True
#c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.bg = 'black'

# Privacy
c.content.proxy = "socks://localhost:9050"
c.content.javascript.enabled = False
c.content.canvas_reading = False # https://en.wikipedia.org/wiki/Canvas_fingerprinting
c.content.webgl = False # https://browserleaks.com/webgl
c.content.tls.certificate_errors = "block"
c.content.headers.accept_language = "en-US,en;q=0.5"
c.content.headers.custom = { "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" }
c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36"
c.content.webrtc_ip_handling_policy = "default-public-interface-only"
c.content.blocking.hosts.lists = (
 [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
 , "https://raw.githubusercontent.com/imkarthikk/pihole-facebook/master/pihole-facebook.txt"
 , "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
 , "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
 , "https://v.firebog.net/hosts/static/w3kbl.txt"
 , "https://adaway.org/hosts.txt"
 , "https://v.firebog.net/hosts/AdguardDNS.txt"
 , "https://v.firebog.net/hosts/Admiral.txt"
 , "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
 , "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
 , "https://v.firebog.net/hosts/Easylist.txt"
 , "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
 , "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"
 , "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
 , "https://v.firebog.net/hosts/Easyprivacy.txt"
 , "https://v.firebog.net/hosts/Prigent-Ads.txt"
 , "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"
 , "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
 , "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
 , "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
 , "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt"
 , "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt"
 , "https://v.firebog.net/hosts/Prigent-Crypto.txt"
 , "https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt"
 , "https://phishing.army/download/phishing_army_blocklist_extended.txt"
 , "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
 , "https://v.firebog.net/hosts/Shalla-mal.txt"
 , "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
 , "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"
 , "https://urlhaus.abuse.ch/downloads/hostfile/"
 , "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser"
 , "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
 , "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
 , "https://v.firebog.net/hosts/static/w3kbl.txt"
 , "https://raw.githubusercontent.com/matomo-org/referrer-spam-blacklist/master/spammers.txt"
 , "https://someonewhocares.org/hosts/zero/hosts"
 , "https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts"
 , "https://winhelp2002.mvps.org/hosts.txt"
 , "https://v.firebog.net/hosts/neohostsbasic.txt"
 , "https://raw.githubusercontent.com/RooneyMcNibNug/pihole-stuff/master/SNAFU.txt"
 , "https://paulgb.github.io/BarbBlock/blacklists/hosts-file.txt"
 , "https://adaway.org/hosts.txt"
 , "https://v.firebog.net/hosts/AdguardDNS.txt"
 , "https://v.firebog.net/hosts/Admiral.txt"
 , "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
 , "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
 , "https://v.firebog.net/hosts/Easylist.txt"
 , "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
 , "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"
 , "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
 , "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts"
 , "https://v.firebog.net/hosts/Easyprivacy.txt"
 , "https://v.firebog.net/hosts/Prigent-Ads.txt"
 , "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"
 , "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
 , "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
 , "https://hostfiles.frogeye.fr/multiparty-trackers-hosts.txt"
 , "https://www.github.developerdan.com/hosts/lists/ads-and-tracking-extended.txt"
 , "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt"
 , "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt"
 , "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/AmazonFireTV.txt"
 , "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt"
 , "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
 , "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt"
 , "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt"
 , "https://v.firebog.net/hosts/Prigent-Crypto.txt"
 , "https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt"
 , "https://phishing.army/download/phishing_army_blocklist_extended.txt"
 , "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
 , "https://v.firebog.net/hosts/Shalla-mal.txt"
 , "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
 , "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"
 , "https://urlhaus.abuse.ch/downloads/hostfile/"
 , "https://v.firebog.net/hosts/Prigent-Malware.txt"
 , "https://raw.githubusercontent.com/HorusTeknoloji/TR-PhishingList/master/url-lists.txt"
 , "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser"
 ])

# Adblocking
c.content.blocking.enabled = True

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
config.bind(";t", "hint links spawn --detach tempbrowser {hint-url}", mode="normal")
config.bind(";n", "hint links spawn --detach newbrowser {hint-url}", mode="normal")
config.bind("gt", "spawn --detach tempbrowser {url}", mode="normal")
config.bind("gn", "spawn --detach newbrowser {url}", mode="normal")

# I don't use bookmarks
config.unbind('wB')
config.unbind('gb')
config.unbind('gB')
config.unbind('Sb')

# Allowing javascript for...
allowed = [ 'https://duckduckgo.com/*'
          , 'https://github.com/*'
          , 'https://secure.ogone.com/*'                 # bancontact
          , 'https://belgium-3dsecure.wlp-acs.com/*'     # bancontact
          , 'https://belgium-3ds.wlp-acs.com/*'          # bancontact
          , 'https://bcr.girogate.be/*'                  # bancontact
          , 'https://bancontact.girogate.be/*'           # bancontact
          , 'https://belgium-uvj-3dsecure.wlp-acs.com/*' # bancontact
          , 'https://*.triodos.be/*'
          , 'https://www.openstreetmap.org/*'
          , 'https://*.zeus.gent/*'
          , 'https://zeus.gent/*'
          , 'https://posteo.de/*'
          , 'https://doc.rust-lang.org/*'
          , 'https://www.paypal.com/*'
          , 'https://www.paypal-topup.be/*'
          , 'https://argenta.be/*'
          , 'https://homebank.argenta.be/*'
          , 'https://*.facebookwkhpilnemxj7asaniu7vnjjbiltxjqhye3mhbshg7kx5tfyd.onion/*'
          ]

for pattern in allowed:
    config.set('content.javascript.enabled', True, pattern)

# Allowing cookies for...
c.content.cookies.accept = "never"
allowed = [ 'https://github.com/*'
          , 'https://*.triodos.be/*'
          , 'https://*.zeus.gent/*'
          , 'https://zeus.gent/*'
          , 'https://posteo.de/*'
          , 'https://argenta.be/*'
          , 'https://homebank.argenta.be/*'
          , 'https://*.facebookwkhpilnemxj7asaniu7vnjjbiltxjqhye3mhbshg7kx5tfyd.onion/*'
          , 'https://adventofcode.com/*'
          ]
for pattern in allowed:
    config.set('content.cookies.accept', "no-3rdparty", pattern)

# Some redirects
redirects = { 'www.reddit.com': 'www.teddit.net'
            , 'www.youtube.com': 'c7hqkpkpemu6e7emz5b4vyz7idjgdvgaaa3dyimmeojqbgpea3xqjoid.onion'
            , 'www.youtube.be': 'c7hqkpkpemu6e7emz5b4vyz7idjgdvgaaa3dyimmeojqbgpea3xqjoid.onion'
            , 'youtu.be': 'c7hqkpkpemu6e7emz5b4vyz7idjgdvgaaa3dyimmeojqbgpea3xqjoid.onion'
            , 'twitter.com': '3nzoldnxplag42gqjs23xvghtzf6t6yzssrtytnntc6ppc7xxuoneoad.onion'
            , 'www.twitter.com': '3nzoldnxplag42gqjs23xvghtzf6t6yzssrtytnntc6ppc7xxuoneoad.onion'
            , 'mobile.twitter.com': '3nzoldnxplag42gqjs23xvghtzf6t6yzssrtytnntc6ppc7xxuoneoad.onion'
            }

nohttps = [ 'c7hqkpkpemu6e7emz5b4vyz7idjgdvgaaa3dyimmeojqbgpea3xqjoid.onion'
          , 'juy4e6eicawzdrz7.onion'
          , 'hmfztxt3pfhevucl.onion'
          , 'upzhip7hatfbsi5xcwyw6n2bpappt3j4gkvwjmyb7qo6urcyhmlekpad.onion'
          , '3nzoldnxplag42gqjs23xvghtzf6t6yzssrtytnntc6ppc7xxuoneoad.onion'
          ]

@interceptor.register
def intercept(info: interceptor.Request) -> None:
    if not info.request_url.scheme().startswith('http'):
        return

    new_url = QUrl(clear_url(info.request_url.url()))

    if new_host := redirects.get(new_url.host()):
        new_url.setHost(new_host)

    if new_url.scheme() == 'https' and new_url.host() in nohttps:
        new_url.setScheme('http')

    if new_url != info.request_url:
        info.redirect(new_url)
