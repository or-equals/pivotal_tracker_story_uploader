defmodule PivotalTrackerStoryUploader.ControllerBehavior do

  @callback reader(file :: String.t()) :: String.t()
  @callback get_stories(file :: String.t()) :: nonempty_list()

end
