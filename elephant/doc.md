### Elephant Websearch

Search the web with custom defined search engines.

#### Example entry

```toml
[[entries]]
default = true
name = "Google"
url = "https://www.google.com/search?q=%TERM%"
```

`~/.config/elephant/websearch.toml`
#### Config
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|icon|string|depends on provider|icon for provider|
|name_pretty|string|depends on provider|displayed name for the provider|
|min_score|int32|depends on provider|minimum score for items to be displayed|
|hide_from_providerlist|bool|false|hides a provider from the providerlist provider. provider provider.|
|entries|[]main.Engine|google|entries|
|history|bool|true|make use of history for sorting|
|history_when_empty|bool|false|consider history when query is empty|
|engines_as_actions|bool|true|run engines as actions|
|always_show_default|bool|true|always show the default search engine when queried|
|text_prefix|string|Search: |prefix for the entry text|
|command|string|xdg-open|default command to be executed. supports %VALUE%.|
#### Engine
| Field | Type | Default | Description |
| --- | ---- | ---- | --- |
|name|string||name of the entry|
|default|bool||entry to display when querying multiple providers|
|prefix|string||prefix to actively trigger this entry|
|url|string||url, example: 'https://www.google.com/search?q=%TERM%'|
|icon|string||icon to display, fallsback to global|
