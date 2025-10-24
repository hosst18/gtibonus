// eslint.config.mjs
import globals from "globals";
import pluginJs from "@eslint/js";

export default [
  {
    ignores: ["**/*.test.js"],
    files: ["**/*.js"],
    languageOptions: { sourceType: "commonjs" },
  },
  { languageOptions: { globals: globals.node } },
  pluginJs.configs.recommended,
  {
    rules: {
      "no-unused-vars": "error",
      "no-undef": "error",
      "no-console": "error",
    },
  },
];
