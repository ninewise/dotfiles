#!/usr/bin/env python3

async def delay(ui, days):
	from datetime import date, timedelta
	datestr = str(date.today() + timedelta(days=days))
	await ui.apply_commandline(f'toggletags inbox,delay,delay/{datestr}')

async def spam(ui):
	from alot.buffers import EnvelopeBuffer
	from alot.db.envelope import Envelope
	from alot.settings.const import settings
	message = ui.current_buffer.get_selected_message()
	message.add_tags(['spam'])
	message.remove_tags(['unread'])
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
