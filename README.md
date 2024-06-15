# PEX Running example

Running a FastApi app encapsulating dependencies inside [Pex](https://docs.pex-tool.org/).


## Standalone FastApi app

Build the pex file with the app
```bash
docker compose run --rm pex . -c uvicorn --inject-args 'app.main:app --host fastapi' -o binaries/fastapi_app.pex
```
- Running `pex .` will install the fastapi_app as a package with all source code needed.
with `-c` uvicorn command will be ran as the entrypoint with `--inject-args` arguments.

Run the app using the pex binary
```bash
docker compose up fastapi
``` 
The uvicorn server will start and serve on http://localhost:8000/

**note**: the `fastapi` compose runs on a clean python container with deps installed and **without** sources

## Packaging App dependencies - not the source code
The difference is not to install the app as a package.

Build the pex file with deps
```bash
docker compose run --rm pex -r requirements.txt -c uvicorn -o binaries/uvicorn.pex
```
Start the server
```bash
docker compose up uvicorn
```
**notes**:

uvicorn compose entrypoint: 
```yaml
entrypoint: ["./binaries/uvicorn.pex", "src.app.main:app", "--host", "uvicorn"]
```
source code is needed, thats why the app path changed `src.app.main:app` and the volume now binds the root dir.

This approach is mode useful for commands or just using differente arguments with the same binary

# Pex

## Build example

distribute the app with deps with pex
```bash
docker compose run --rm pex . -o ./binaries/env.pex
```
then:
```
root@0df666ae840a:/code/binaries# ./env.pex 
Python 3.10.14 (main, Jun 13 2024, 06:49:33) [GCC 12.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
>>> import app
>>>
```