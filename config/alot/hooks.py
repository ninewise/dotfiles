
from alot.commands.globals import ExternalCommand

def loop_hook(ui=None):
    ui.apply_command(ExternalCommand(
            ["notmuch", "new", "--quiet"],
            thread=True,
    ))
    if ui and ui.current_buffer:
        ui.update()

