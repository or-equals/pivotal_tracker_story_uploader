defmodule PivotalTrackerStoryUploader.Token do

  alias PivotalTrackerStoryUploader.Controller

  def get_api_token(file) do
    file
    |> Controller.reader
    |> fetch_token
  end

  defp fetch_token(string) do
    [top, _stories] = String.split(string, "\n\n")
    [author, _project, _owners] = String.split(top, "\n")

    cond do
      author == author_1() ->
        Application.fetch_env!(:pivotal_tracker_story_uploader, :token_1)

      author == author_2() ->
        Application.fetch_env!(:pivotal_tracker_story_uploader, :token_2)

      author != author_1() || author != author_2() ->
        "Invalid author"
    end
  end

  defp author_1 do
    Application.fetch_env!(:pivotal_tracker_story_uploader, :author_1)
  end
  defp author_2 do
    Application.fetch_env!(:pivotal_tracker_story_uploader, :author_2)
  end
end
