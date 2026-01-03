# renovate-config

Personal opinionated [Renovate config presets](https://docs.renovatebot.com/config-presets/).

## Usage

For most code bases - using [`default.json`](./default.json):

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": ["github>henrist/renovate-config:default"]
}
```

For libraries - using [`library.json`](./library.json):

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": ["github>henrist/renovate-config:library"]
}
```

## Recipes

This is a collection of Renovate configs I typically use
in various projects.

### Automerge dev deps

```json
{
  "packageRules": [
    {
      "matchDepTypes": ["devDependencies"],
      "matchUpdateTypes": ["minor", "patch"],
      "automerge": true,
      "automergeType": "branch"
    }
  ]
}
```

### Regex matcher

Used in: https://github.com/blindern/drift

```json
{
  "regexManagers": [
    {
      "fileMatch": [
        "(^|/|\\.)Dockerfile$",
        "(^|/)Dockerfile[^/]*$"
      ],
      "matchStrings": [
        "datasource=(?<datasource>.*?) depName=(?<depName>.*?)\\sENV .*?_VERSION=(?<currentValue>.*)\\s",
        "datasource=(?<datasource>.*?) depName=(?<depName>.*?) tag=(?<currentValue>.*)\\sENV .*?_COMMIT=(?<currentDigest>[a-f0-9]{40})\\s"
      ]
    }
  ]
}
```

Example in dependency file:

```text
# renovate: datasource=git-refs depName=https://github.com/path/to/repo.git tag=master
ENV SOME_COMMIT=3e7433d943e7e0a80068c26b21703e04c2af5f8f
```

### Split lock file updates

```json
{
  "lockFileMaintenance": {
    "enabled": true,
    "branchTopic": "lock-file-maintenance-{{packageFile}}",
    "commitMessageExtra": "({{packageFile}})"
  }
}
```
