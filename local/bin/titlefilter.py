#!/bin/env python3
# Filter items not containing keywords (given as parameters) from a rss feed.
# Reads stdin, writes stdout.

import sys

# The hard way, pretty clean but doesn't work (probably) because HTMLParser puts
# all the tags in lowercase.

#from html.parser import HTMLParser
#from itertools import chain

#def start_to_tag(tag, attrs, end=False):
#    if end:
#        items = chain([tag], ('{}="{}"'.format(n,v) for (n,v) in attrs), ['/'])
#    else:
#        items = chain([tag], ('{}="{}"'.format(n,v) for (n,v) in attrs))
#    return "<{}>".format(" ".join(items))
#
#class FeedParser(HTMLParser):
#
#    def __init__(self, keep):
#        super().__init__(self)
#        self.keep = keep
#        self.parts = []
#        self.item = None
#
#    def handle_starttag(self, tag, attrs, end=False):
#        string = start_to_tag(tag, attrs, end=end)
#        if tag == "item":
#            self.item = string
#        elif self.item is None:
#            self.parts.append(string)
#        else:
#            self.item += string
#
#    def handle_endtag(self, tag):
#        string = "</{}>".format(tag)
#        if self.item is None:
#            self.parts.append(string)
#        elif tag == "item":
#            if any(title in self.item for title in self.keep):
#                string = self.item + string
#            else:
#                string = ""
#            self.item = None
#            self.parts.append(string)
#        else:
#            self.item += string
#
#    def handle_startendtag(self, tag, attrs):
#        self.handle_starttag(tag, attrs, end=True)
#
#    def handle_data(self, data):
#        if self.item is None:
#            self.parts.append(data)
#        else:
#            self.item += data
#
#    def handle_entityref(self, data):
#        self.handle_data("&{};".format(data))
#
#    def handle_charref(self, data):
#        self.handle_data("$#{};".format(data))

#parser = FeedParser(sys.argv)
#parser.feed(sys.stdin.read())
#parser.close()

#print(''.join(parser.parts), end='')

# The easy way. Works.
def check(block):
    if '</item>' not in block: return True
    if any(title in block for title in sys.argv): return True
    return False

print('<item>'.join(filter(check, sys.stdin.read().split('<item>'))), end='')
