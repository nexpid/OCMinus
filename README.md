<h1 align="center"><img src="./assets/OCMinus.png" width="384" alt="OCMinus Logo"></h1>
<p align="center">The best Roblox enhancement mod ever created.</p>

## Loading

You can load the OCMinus script by using this simple script!

```lua
local OCMinusURL = {
    protocol = "https",
    protocolFormat = "://",
    host = "raw.githubusercontent.com",
    path = "/Gabe616/OCMinus/main/",
    file = "script.lua"
}
local OCMinusUrlFormat = "%s%s%s%s%s"
local OCMinusFullUrl = OCMinusUrlFormat:format(
    OCMinusURL.protocol,
    OCMinusURL.protocolFormat,
    OCMinusURL.host,
    OCMinusURL.path,
    OCMinusURL.file
)

local OCMinusLoadedScript = game.HttpGet(game, OCMinusFullUrl)

local OCMinusLoaderFunction = loadstring
local OCMinusLoadedFunctionRunner = OCMinusLoaderFunction(OCMinusLoadedScript)
OCMinusLoadedFunctionRunner()
```

## Executors

| Executor    | My personal opinion on it                                      | Works        |
| ----------- | -------------------------------------------------------------- | ------------ |
| Hydrogen    | I have never used this executor and therefore cannot judge it. | idk          |
| Coco Z      | I don't use this executor therefore I cannot judge it.         | no clue      |
| KRNL        | I use this executor therefore I cannot judge it.               | i think so   |
| Fluxus      | I don't use this executor either therefore I cannot judge it.  | maybe        |
| Kiwi X      | I've never used this executor therefore I cannot judge it.     | possibly     |
| Script-Ware | I never bought this executor therefore I cannot judge it.      | probably yes |
| Synapse     | I've never bought this executor therefore I cannot judge it.   | i don't know |

## FAQ

### What is OC-?

OC- is a continuation of OC+, which helps players not get overstimulated while playing Obby Creator!

### The script doesn't work!

I don't care
