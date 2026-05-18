// CH-curated tool surface for tools.campaign.help/tools/
// Tools listed here appear on the home view. All other tools remain
// reachable via direct URL but are hidden from the home navigation.
//
// Keys here are the `path` values from each tool's defineTool() call
// (e.g., /qrcode-generator), NOT the directory names.
//
// Key substitutions from the spec (upstream names that don't exist):
//   password-generator     -> /token-generator
//   json-formatter         -> /json-prettify  (json-viewer dir)
//   date-time-converter    -> /date-converter  (date-time-converter dir)
//   markdown-preview       -> /markdown-to-html
//   qr-code-generator      -> /qrcode-generator

export const CH_CURATED_TOOL_PATHS: ReadonlySet<string> = new Set([
  '/qrcode-generator',
  '/token-generator',
  '/base64-string-converter',
  '/url-encoder',
  '/json-prettify',
  '/date-converter',
  '/hash-text',
  '/color-converter',
  '/markdown-to-html',
  '/text-statistics',
]);

export const isCurated = (toolPath: string): boolean =>
  CH_CURATED_TOOL_PATHS.has(toolPath);
