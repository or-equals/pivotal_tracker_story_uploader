defmodule PivotalTrackerStoryUploader.ControllerTest do
  use ExUnit.Case

  alias PivotalTrackerStoryUploader.Controller

  test "get_stories" do
    file = Application.fetch_env!(:pivotal_tracker_story_uploader, :test_file_1)
    assert Controller.get_stories(file) == ["New story 1", "New story 2"]
  end

end
