defmodule PivotalTrackerStoryUploader.Members do

  alias PivotalTrackerStoryUploader.HttpAdapter
  alias PivotalTrackerStoryUploader.Controller
  alias PivotalTrackerStoryUploader.ProjectId

  def get_members(file) do
    file
    |> fetch_members_list
    |> modify_members_list
  end

  defp url(file) do
    Application.fetch_env!(:pivotal_tracker_story_uploader, :base_url)
    <> "/"
    <> ProjectId.get_project_id(file)
    <> "/memberships"
  end

  defp fetch_members_list(file) do
    Controller.do_get(url(file), file)
    |> HttpAdapter.process_response_body
  end

  defp modify_members_list(list) do
    {:ok, list} = list
      for person <- list do
        %{
          name: person["person"]["name"],
          id: person["person"]["id"]
        }
    end
  end

end
