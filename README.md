# Pivotal Tracker Story Uploader
A program designed to add new stories to the Pivotal Tracker Icebox by submiting post requests to the Pivotal Tracker API .

## Dependencies
```
{:poison, "~> 3.1"},
{:httpoison, "~> 1.7"},
```

## File format

The .txt file must have the following format: <br>
<br>
author_name<br>
project_name<br>
owner_names<br>

sample_story_1<br>
sample_story_2<br>
...

## How to use
```
PivotalTrackerStoryUploader.Controller.run("test.txt")
```
