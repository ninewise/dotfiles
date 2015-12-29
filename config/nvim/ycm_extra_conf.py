
def FlagsForFile(filename, **kwargs):
    c = filename.endswith('.c')
    flags = [
        '-Wall',
        '-Wextra',
        '-Werror',
        '-DNDEBUG',
        '-std=c99' if c else '-std=c++11',
        '-x', 'c' if c else 'c++',
        '-isystem', '/usr/include',
    ]
    return dict(flags=flags, do_cache=True)
