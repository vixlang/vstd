# vstd

Standard library modules for Vix 0.4.6. Import the package from a project root
with `mod vstd`; functions are called through their full module path, for
example `vstd::array::push(&values, VInt(1))`.

The library intentionally uses concrete containers around the shared `Value`
ADT because generic struct literals are not yet supported by the compiler.
Mutable containers are passed by reference so array growth is retained by the
caller.

Modules:

- `types`: `Value`, `Pair`, `Ordering`, `Result`, and concrete container types
- `mem`: allocation, release, copy, fill, and comparison
- `str`: duplication, comparison, prefix/suffix, and substring checks
- `array`: mutable `ValueArray`
- `list`: mutable ordered `ValueList`
- `map`: string-keyed `ValueMap` with insert/update/lookup
- `json`: strict JSON parsing, recursive serialization, and object/array queries
- `io`: console output and whole-file reads/writes
- `os`: commands, environment lookup, and process termination
- `rand`: seeding and bounded pseudo-random integers
- `time`: Unix time and millisecond sleep
- `net`: DNS-backed TCP request/response
- `http`: HTTP/1.0 GET over TCP

Tests live under `tests/`. The `tests/vstd` symlink is required by the current
Vix module resolver.

## JSON

`vstd::json::parse` returns `Ok(Value)` or a readable `Err(string)`.
Objects use `VPairs`, arrays use `VList`, and values can be queried with
`vstd::json::get` and `vstd::json::at`.

```sh
cd /home/zty/vstd
/home/zty/Vix-lang/build/vixc tests/test_json_parse.vix -o /tmp/test_json_parse
/tmp/test_json_parse
```

## vlibcurl

`vlibcurl` is separate from `vstd` so programs that do not use HTTP do not
need to link libcurl. `CurlRequest` supports a base URL, endpoint, method,
body, headers, bearer token, and caller-selected response file. Convenience
functions cover GET, JSON POST, and OpenAI-compatible chat completion POSTs.

```sh
cd /home/zty/vstd
/home/zty/Vix-lang/build/vixc tests/test_vcurl.vix -lcurl -o /tmp/test_vcurl
/tmp/test_vcurl
```

The real DeepSeek test is opt-in and never stores or prints the API key:

```sh
export RUN_DEEPSEEK_INTEGRATION=1
export DEEPSEEK_API_KEY='replace-with-a-current-key'
export DEEPSEEK_BASE_URL='https://api.deepseek.com'   # optional
export DEEPSEEK_MODEL='deepseek-chat'                 # optional
/home/zty/Vix-lang/build/vixc tests/test_vcurl_deepseek.vix -lcurl -o /tmp/test_vcurl_deepseek
/tmp/test_vcurl_deepseek
```

Without `RUN_DEEPSEEK_INTEGRATION=1` or a key, the integration test prints
`SKIP` and exits successfully.

## vlibtui

`vlibtui` is a model-independent terminal library with raw-mode lifecycle,
cursor and screen operations, key input (including arrow keys), buffered ANSI
rendering, a text block, input box, and scrollable message list.

Run the non-interactive render test:

```sh
cd /home/zty/vstd
/home/zty/Vix-lang/build/vixc tests/test_vlibtui_render.vix -o /tmp/test_vlibtui_render
/tmp/test_vlibtui_render
```

Build and manually run the interactive demo in a real terminal:

```sh
cd /home/zty/vstd
/home/zty/Vix-lang/build/vixc examples/tui_demo.vix -o /tmp/tui_demo
/tmp/tui_demo
```

Type text and press Enter to append it, use Up/Down to scroll, and press `q`
on an empty input or `Ctrl-C` to leave. Raw mode and cursor visibility are
restored on normal exit, `Ctrl-C`, `SIGTERM`, and the registered exit
handler.
