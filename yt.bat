::Search movie names to be directed to a new youtube tab in browser by provision of a list
@echo off
setlocal enabledelayedexpansion

:: Set the path to Brave's executable. Adjust this path if Brave is installed in a different location.
set "brave_path=C:\Users\Parshwa\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Brave.lnk"

:: Prompt the user to enter movie names (one per line, end with a blank line)
echo Enter movie names, one per line (end input with a blank line):
set "movies="

:input_loop
set "line="
set /p line=Movie: 
if not defined line goto end_input

:: Append the input to the movies variable
set "movies=%movies%%line%,"

goto input_loop

:end_input

:: Loop through each movie name, split by commas (from the above concatenation)
for %%a in ("%movies:,=" "%") do (
    :: Remove leading/trailing spaces and replace spaces with '+'
    set "movie_search=%%~a"
    set "movie_search=!movie_search: =+!"

    :: Append "trailer" to the movie name
    set "movie_search=!movie_search!+trailer"

    :: Construct the YouTube search URL
    set "url=https://www.youtube.com/results?search_query=!movie_search!"

    :: Open the search URL in Brave browser
    start "" "%brave_path%" "!url!"
)

:: Pause to keep the window open after execution
pause
