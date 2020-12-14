defmodule PivotalTrackerStoryUploader.Controller do

  alias PivotalTrackerStoryUploader.HttpAdapter
  alias PivotalTrackerStoryUploader.Token
  alias PivotalTrackerStoryUploader.Owners
  alias PivotalTrackerStoryUploader.ProjectId

  def run(file) do
    file
    |> create_payload
  end

  def reader(file) do
    {:ok, content} = File.read(file)
    content |> String.trim()
  end

  def get_stories(file) do
    file
    |> reader
    |> fetch_stories
  end

  defp fetch_stories(string) do
    [_top, headers] = String.split(string, "\n\n")
    String.split(headers, "\n")
  end

  def create_payload(file) do
    for story <- get_stories(file) do
      %{
        name: story,
        estimate: 2,
        owner_ids: Owners.get_owners(file)
      }

      |> HttpAdapter.encode_params_to_json
      |> post_params(file)
    end
  end

  def post_params(params, file) do
    {:ok, params} = params
      do_post(params, file)
  end

  def headers(file) do
    [
      {"X-TrackerToken", "#{Token.get_api_token(file)}"},
      {"Content-Type", "application/json"}
    ]
  end

  def do_get(url, file) do
    HttpAdapter.get(url, headers(file))
    |> handle_response
  end

  def do_post(params, file) do
    HttpAdapter.post(url(file), params, headers(file))
    |> handle_response
  end

  def url(file) do
    Application.fetch_env!(:pivotal_tracker_story_uploader, :base_url)
    <> "/"
    <> ProjectId.get_project_id(file)
    <> "/stories"
  end

  def handle_response(resp) do
    case resp do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        body
      {:ok, %HTTPoison.Response{body: body, status_code: 403}} ->
        body
    end
  end

end
