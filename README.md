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

Opt-in automerge of a curated low-risk set - using [`automated.json`](./automated.json):

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "github>henrist/renovate-config:default",
    "github>henrist/renovate-config:automated"
  ]
}
```

Aggressive automerge of all non-major - using [`automated-aggressive.json`](./automated-aggressive.json):

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "github>henrist/renovate-config:default",
    "github>henrist/renovate-config:automated-aggressive"
  ]
}
```

`:automated` and `:automated-aggressive` are designed to layer on top of `:default`. Used standalone they lose `minimumReleaseAge` and other safety rails.

## Recipes

This is a collection of Renovate configs I typically use
in various projects.

### Regex matcher

Used in: https://github.com/blindern/drift

```json
{
  "customManagers": [
    {
      "customType": "regex",
      "managerFilePatterns": [
        "/(^|/|\\.)Dockerfile$/",
        "/(^|/)Dockerfile[^/]*$/"
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
