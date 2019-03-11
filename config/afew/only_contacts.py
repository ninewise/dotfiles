from afew.filters.BaseFilter import Filter
from afew.FilterRegistry import register_filter

from khard.config import Config

import re

@register_filter
class TagOrContact(Filter):
	message = 'Allow only tagged messages from non-contacts'
	user = None
	domain = None

	def __init__(self, database, **kwargs):
		super(TagOrContact, self).__init__(database, **kwargs)
		self._extract_tag_re = re.compile(f'[^+]+(\+(?P<tag>[^@]+))?@[^@]+')
		self._bare_email_re = re.compile(r'[^<]*<(?P<email>[^@<>]+@[^@<>]+)>')
		self._contactbook = Config().abook

	def handle_message(self, message):
		recipient = message.get_header('Delivered-To')
		match = self._extract_tag_re.fullmatch(recipient)
		if match is None: return # wrong email

		if match.group('tag'):
			self.add_tags(message, match['tag'])
		else:
			sender = message.get_header('From')
			if '<' in sender: sender = self._bare_email_re.fullmatch(sender)['email']
			if self._contactbook.search(sender):
				self.add_tags(message, 'contact')
			else:
				self.add_tags(message, 'killed')
