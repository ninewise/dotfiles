#!/usr/bin/python

from pyquery import PyQuery as pq
from pprint import pprint
import sys

ITEM = """
<item>
    <title>{title}</title>
    <description>{description}</description>
    <link>{link}</link>
</item>"""

class Release(object):

    def __init__(self, title, link):
        self.title = title
        self.link = link

    def __str__(self):
        return ITEM.format(
            title=self.title,
            description="New release: {}".format(self.title),
            link=self.link)

    def __contains__(self, string):
        return string in self.title or string in self.link

latest = pq(url="http://www.mangahere.co/latest/")

print("""\
<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0">
<channel>""")

for item in map(pq, latest("dd > a")):
    release = Release(item.attr("title"), item.attr("href"))
    if any(word in release for word in sys.argv):
        print(str(release))

print("""
</channel>
</rss>
""")
