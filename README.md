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
- `json`: recursive JSON serialization for `Value`
- `io`: console output and whole-file reads/writes
- `os`: commands, environment lookup, and process termination
- `rand`: seeding and bounded pseudo-random integers
- `time`: Unix time and millisecond sleep
- `net`: DNS-backed TCP request/response
- `http`: HTTP/1.0 GET over TCP

Tests live under `tests/`. The `tests/vstd` symlink is required by the current
Vix module resolver.
