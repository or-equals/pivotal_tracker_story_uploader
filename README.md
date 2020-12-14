# Pivotal Tracker Story Uploader
A program designed to add new stories to the Pivotal Tracker Icebox by submiting post requests to the Pivotal Tracker API .

## Getting Started

Add dependencies: 
```
{:poison, "~> 3.1"},
{:httpoison, "~> 1.7"},
```

## How to Use

The .txt file must follow the following format: <br>
author_name<br>
project_name<br>
owner_names<br>

sample_story_1<br>
sample_story_2<br>
...


```
Command line:
PivotalTrackerStoryUploader.Controller.run("test.txt")
```
