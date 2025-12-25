# microsoft-rewards-searching
ueses ahk to search with Ollama as an optional addition

## steps to use base without ai
1. install ahk v2
2. download constants.ahk, gui.ahk, and microsoftsearcher.ahk
3. put the .ahk files into a folder
4. run microsoftsearcher.ahk

## steps to use ai
1. install Ollama via https://ollama.com/download
2. create an account to be able to use any cloud model or install one fully.
3. open command prompt and do 'ollama pull "model"'. example: "ollama pull nemotron-3-nano:30b-cloud"
4. do "ollama list" to make sure model shows up and was installed correctly
5. install the cJson.ahk library at https://github.com/G33kDude/cJson.ahk/releases/tag/2.1.0
6. put the JSON.ahk, microsoftsearcher.ahk, gui.ahk, and constants.ahk into a single folder
7. run microsoftsearcher.ahk
8. click the "Update Model List" button to update the models you can use to the ones you installed
9. choose the one you want to use in the drop down list