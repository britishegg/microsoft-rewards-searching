# microsoft-rewards-searching
ueses ahk to search with Ollama as an optional addition

# steps to use base without ai
1. install ahk v2
2. download constants, gui, and microsoftsearcher.ahk
3. put the .ahk files into a folder
4. run microsoftsearcher.ahk

# steps to use ai
1. install ollama via https://ollama.com/download
2. create an account to be able to use any cloud model or just install one. the built in ones are https://ollama.com/library/gpt-oss, https://ollama.com/library/gemini-3-flash-preview, and https://ollama.com/library/nemotron-3-nano.
3. open command prompt and do 'ollama pull "model"'. example: "ollama pull nemotron-3-nano:30b-cloud"
4. do "ollama list" to make sure model shows up and was installed correctly
5. install the cJson.ahk library at https://github.com/G33kDude/cJson.ahk 
6. put the .ahk file you download, microsoftsearcher, gui, and constants.ahk into a single folder
6. run microsoftsearcher.ahk