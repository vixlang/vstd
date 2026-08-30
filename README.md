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

UI modules:

- `tinyui`: backend-independent widget tree with windows, rows, columns, labels,
  buttons, inputs, and child composition
- `tinyui_gtk`: GTK3 binding using opaque widget handles, event callbacks, and
  the GTK main loop

The GTK demo can be checked and built with GTK3 development files installed:

```bash
make gtk-check
make gtk-build
./build/tinyui_gtk_demo
```

GTK applications should be linked with the GTK3 libraries returned by
`pkg-config --libs-only-l gtk+-3.0`.

Vedior Vix source editor:

```bash
make editor-build
./build/vix_editor path/to/file.vix
```

The editor provides a VS Code-inspired explorer sidebar, file tab, monospace
GTK text view, file loading, and saving. The implementation demonstrates Vix
ADTs, `match`, pipe expressions, macros, and expression-form `if ... else`.
