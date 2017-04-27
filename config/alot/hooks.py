
from alot.commands.globals import ExternalCommand
from alot.commands.search import OpenThreadCommand

def loop_hook(ui=None):
    ui.apply_command(ExternalCommand(
            ["notmuch", "new", "--quiet"],
            thread=True,
    ))
    if ui and ui.current_buffer:
        ui.update()

def post_search_select(ui=None, dbm=None, cmd=None):
    if isinstance(cmd, OpenThreadCommand):
        cmd.thread.remove_tags({"unread"})

