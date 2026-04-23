import { describe, expect, it } from "vitest";
import { Opal } from "@camertron/opal-esm";

describe("Opal", () => {
  it("can run ruby code", () => {
    expect(Opal.send(1, "+", [2])).toEqual(3);
  });

  it("does not decorate globalThis (i.e. window)", () => {
    expect(globalThis.window?.Opal).toBeUndefined();
  });
});
