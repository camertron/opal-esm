## @camertron/opal-esl

![Unit Tests](https://github.com/camertron/opal-esm/actions/workflows/unit_tests.yml/badge.svg?branch=main)

## What is this thing?

This package contains a copy of the Opal runtime, packaged as a series of ESM modules. Opal is normally evaluated directly on the page and thus attaches itself to `window`. This library prevents that behavior and instead allows importing and creating locally-scoped instances of the runtime.

## Usage

Import Opal using a standard ESM import statement:

```javascript
import { Opal } from "@camertron/opal-esm";

Opal.Kernel.$puts("Hello, world!");
```

## Running Tests

`npm test` should do the trick.

## License

Licensed under the MIT license. See LICENSE for details.

## Authors

* Cameron C. Dutro: http://github.com/camertron
