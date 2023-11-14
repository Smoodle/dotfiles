#!/usr/bin/env python

import http.server
import socketserver
import os.path
import sys
from pathlib import Path

PORT = 8123


class ServerHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if not os.path.exists(os.path.curdir + self.path):
            for child in Path(os.path.abspath(os.path.curdir + self.path.replace(os.path.basename(self.path), ''))).iterdir():
                if os.path.basename(child.name).lower() == os.path.basename(self.path).lower():
                    child.rename(os.path.abspath(os.path.curdir + self.path))
                    break

        http.server.SimpleHTTPRequestHandler.do_GET(self)

    def do_POST(self):
        http.server.SimpleHTTPRequestHandler.do_POST(self)


with socketserver.TCPServer(("", PORT), ServerHandler) as httpd:
    print("serving at address: http://localhost:" + str(PORT))
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("Closing server")
        httpd.server_close()
        sys.exit(0)
