## @camertron/opal-esm

![Unit Tests](https://github.com/camertron/opal-esm/actions/workflows/unit_tests.yml/badge.svg?branch=main)

## What is this thing?

This package contains a copy of the Opal runtime, packaged as a series of ESM modules. Opal is normally evaluated directly on the page and thus attaches itself to `window`. This library prevents that behavior and instead allows importing and creating locally-scoped instances of the runtime.

## Usage

Import Opal using a standard ESM import statement:

```javascript
import { Opal } from "@camertron/opal-esm";

Opal.Kernel.$puts("Hello, world!");
```

### Importing stdlib modules

Opal includes an implementation of the Ruby standard library. To make these modules available to your ES module, all you have to do is import them.

```javascript
import { Opal } from "@camertron/opal-esm";
import "@camertron/opal-esm/base64"

Opal.require("base64");

const base64_module = Opal.Kernel.$const_get("Base64");
const encoded = Opal.send(base64_module, "encode64", ["foobar"]);

console.log(encoded)  // prints "Zm9vYmFy\n"
```

## Isolation

Note that, although opal-esm allows the Opal runtime to be imported without modifying `window`, separate `import`s do not create more than one copy of the Ruby runtime. All `require`s, etc affect the same execution context.

## Running Tests

`npm test` should do the trick.

## License

Licensed under the MIT license. See LICENSE for details.

## Authors

* Cameron C. Dutro: http://github.com/camertron
