# renovate-config

Personal opinionated [Renovate config presets](https://docs.renovatebot.com/config-presets/).

## Usage

For most code bases - using [`default.json`](./default.json):

```json
{
  "extends": ["github>henrist/renovate-config:default"]
}
```

For libraries - using [`library.json`](./library.json):

```json
{
  "extends": ["github>henrist/renovate-config:library"]
}
```
