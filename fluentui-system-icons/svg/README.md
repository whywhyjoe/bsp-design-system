# Fluent UI icon assets

This folder contains Fluent UI SVG icons collected into one flat directory.

- `metadata.json` is the combined catalog of all icons.
- Each entry in `metadata.json` has the original icon metadata plus a
  `filenames` array listing its SVG files.
- SVG files are available directly in this folder, so a filename can be used
  as a relative path, for example `ic_fluent_access_time_24_regular.svg`.

## Find an icon

`metadata.json` has an `icons` array. Search the entries by:

- **Name:** use the `name` field, such as `"Access Time"`.
- **Purpose:** search `description`, `metaphor`, or `keyword`.
- **Available files:** read the entry's `filenames` array.

For example, this PowerShell command finds icons whose name, description, or
metaphors mention "zoom":

```powershell
$catalog = Get-Content .\metadata.json -Raw | ConvertFrom-Json
$catalog.icons | Where-Object {
  $_.name -match 'zoom' -or
  $_.description -match 'zoom' -or
  ($_.metaphor -join ' ') -match 'zoom'
} | Select-Object name, description, filenames
```

To use an SVG, select a filename from the matching entry and reference it
directly from this folder:

```text
ic_fluent_zoom_out_24_regular.svg
```

Icons commonly have several sizes and styles, including `regular`, `filled`,
and occasionally other styles such as `light`.
