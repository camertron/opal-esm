import { describe, expect, it } from "vitest";
import { Opal } from "@camertron/opal-esm";
import "@camertron/opal-esm/base64"

describe("Opal standard library", () => {
  it("makes imported modules available on the Opal import", () => {
    expect(Opal.modules["base64"]).toBeDefined();
  });

  it("evaluates imported modules", () => {
    expect(Opal.require("base64")).toBeTruthy();
    const base64_module = Opal.Kernel.$const_get("Base64");
    expect(base64_module).toBeDefined();
    expect(Opal.send(base64_module, "encode64", ["foobar"])).toEqual("Zm9vYmFy\n");
  });
});
