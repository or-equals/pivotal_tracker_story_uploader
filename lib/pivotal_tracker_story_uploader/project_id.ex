defmodule PivotalTrackerStoryUploader.ProjectId do

  alias PivotalTrackerStoryUploader.HttpAdapter
  alias PivotalTrackerStoryUploader.Controller

  def get_project_id(file) do
    Controller.do_get(url(), file)
    |> HttpAdapter.process_response_body
    |> fetch_project_id(file)
  end

  defp url, do: Application.fetch_env!(:pivotal_tracker_story_uploader, :base_url)

  defp fetch_project_id(list, file) do
    {:ok, list} = list

      Enum.find(list, fn project ->
        Map.get(project, "name") == fetch_project_name(file)
      end)
      |> Map.get("id")
      |> to_string
  end

  defp fetch_project_name(file) do
    content = Controller.reader(file)
      [top, _stories] = String.split(content, "\n\n")
      [_author, project, _owners] = String.split(top, "\n")
      project
  end
end
