# Third-party notices

## CrossPoint Sync

This Home Assistant app packages CrossPoint Sync
(https://github.com/crosspoint-reader/crosspoint-sync), unmodified except for an
nginx reverse proxy and a start script.

MIT License

Copyright (c) 2026 CrossPoint Sync contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## npm dependencies

The packaged image contains CrossPoint Sync's production node_modules, which are
distributed under their respective licences. See the upstream
package-lock.json: https://github.com/crosspoint-reader/crosspoint-sync/blob/main/package-lock.json

## Alpine packages

nginx and jq are installed from Alpine Linux and carry their own licences
(BSD-2-Clause for nginx, MIT for jq).
