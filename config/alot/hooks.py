#!/usr/bin/env python3
from datetime import date, timedelta

from alot.buffers import EnvelopeBuffer
from alot.db.envelope import Envelope
from alot.settings.const import settings

async def delay(ui, days):
	datetag = 'delay/' + str(date.today() + timedelta(days=days))

	if ui.current_buffer.modename == 'search':
		messages = ui.current_buffer.get_selected_thread().get_messages().keys()
	elif ui.current_buffer.modename == 'thread':
		messages = [ ui.current_buffer.get_selected_message() ]

	if days != 0:
		for message in messages:
			if 'flagged' in message.get_tags():
				message.add_tags(['delay', datetag])
		await ui.apply_commandline('untag flagged,unread')
	else:
		for message in messages:
			if 'delay' in message.get_tags():
				message.remove_tags([t for t in message.get_tags() if t.startswith('delay')])
				message.add_tags(['flagged'])
		await ui.apply_commandline('untag delay,delay/*')

async def spam(ui):
	message = ui.current_buffer.get_selected_message()
	message.add_tags(['spam'])
	message.remove_tags(['unread', 'flagged'])
	if 'ugent' in message.get_tags():
		envelope = Envelope(
			headers=dict(
				From=['Felix Van der Jeugt <felix.vanderjeugt@ugent.be>'],
				To=['spam@ugent.be'],
				Subject=['spam'],
				References=['<' + message.get_message_id() + '>']),
			bodytext='spam',
			tags=['spam'],
			account=settings.account_matching_address('felix.vanderjeugt@ugent.be'))
	else:
		envelope = Envelope(
			headers=dict(
				From=['Felix Van der Jeugt <felix.vanderjeugt@posteo.net>'],
				To=['spamreport@posteo.de'],
				Subject=['spam'],
				References=['<' + message.get_message_id() + '>']),
			bodytext='',
			tags=['spam'],
			account=settings.account_matching_address('felix.vanderjeugt@posteo.net'))
	envelope.attach(message.get_filename())
	ui.buffer_open(EnvelopeBuffer(ui, envelope))
