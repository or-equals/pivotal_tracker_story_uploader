defmodule PivotalTrackerStoryUploader.TokenTest do
  use ExUnit.Case
  alias PivotalTrackerStoryUploader.Token

  test "get_api_token, author_1" do
    result =
      Application.fetch_env!(:pivotal_tracker_story_uploader, :test_file_valid_author_1)
      |> Token.get_api_token
    assert result === "sample_token_1"
  end

  test "get_api_token, author_2" do
    result =
      Application.fetch_env!(:pivotal_tracker_story_uploader, :test_file_valid_author_2)
      |> Token.get_api_token
    assert result === "sample_token_2"
  end

  test "get_api_token, invalid author" do
    result =
      Application.fetch_env!(:pivotal_tracker_story_uploader, :test_file_invalid_author)
      |> Token.get_api_token
    assert result === "Invalid author"
  end
end
