import sys, os, platform
from qutebrowser.api import interceptor
import dracula.dracula

# Youtube adblock
def filter_yt(info: interceptor.Request):
	"""Block the given request if necessary."""
	url = info.request_url
	if (url.host() == 'www.youtube.com' and
			url.path() == '/get_video_info' and
			'&adformat=' in url.query()):
		info.block()

interceptor.register(filter_yt)

# Misc config
#c.qt.args=["ignore-gpu-blacklist", "enable-gpu-rasterization", "enable-native-gpu-memory-buffers", "num-raster-threads=8"]

config.set("tabs.background", True)

# Binds
config.bind('<Ctrl-Shift-y>', 'hint links spawn mpv {hint-url}')
config.set('content.headers.user_agent', 'Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101 Firefox/77.0', 'https://accounts.google.com/*')

config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
#config.set('statusbar.hide', True)

config.unbind('b')
config.bind('ba', 'bookmark-add')
config.bind('bd', 'bookmark-del')
config.bind('bb', 'bookmark-load')

config.unbind(';i')
config.bind(';if', 'hint images')
config.bind(';id', 'hint images download')

# AdBlock
c.content.blocking.method = 'adblock'

#config.set('content.host_blocking.enabled', False)
#sys.path.append(os.path.join(sys.path[0], "jblock"))
#config.source("jblock/jblock/integrations/qutebrowser.py")
#config.set(
#    "content.host_blocking.lists",
#    [
#        "https://easylist.to/easylist/easylist.txt",
#        "https://easylist.to/easylist/easyprivacy.txt",
#        "https://easylist.to/easylist/fanboy-annoyance.txt",
#        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
#        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt",
#        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
#        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
#        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",
#        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
#    ],
#)

# Platform specific settings

if platform.system() == "Linux":
    FONTSIZE = 10
elif platform.system() == "Darwin":
    FONTSIZE = 12

config.load_autoconfig()

dracula.dracula.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})
